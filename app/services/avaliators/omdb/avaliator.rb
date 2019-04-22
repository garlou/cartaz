module Avaliators
  module OMDB
    class Avaliator < Scrappers::Base

      attr_accessor :url, :search_url

      def initialize
        @url = 'http://www.omdbapi.com/?apikey=ad62658c&i='
        @search_url = 'http://www.omdbapi.com/?apikey=ad62658c&s='
      end

      def run
        unscored_movies.each do |movie|
          search = parse_json("#{search_url}#{URI.encode(movie.title)}")
          process_search(movie, search)
          movie.update_columns(last_avaliation: Time.zone.now)
        rescue KeyError => e
          Rails.logger.error("Movie id #{movie.id}: #{movie.title} - #{e}")
        end
      end

      private

      def process_search(movie, search)
        search.fetch('Search').each do |result|
          similarity = build_similarity(movie, result)
          if similarity > 90
            page = parse_json("#{url}#{result.fetch('imdbID')}")
            proccess_page(movie, page, similarity)
          end
        end
      end

      def proccess_page(movie, page, similarity)
        movie.update(genres: genres(movie, page))
        page.fetch('Ratings').each do |rating|
          source = rating.fetch('Source')
          score = movie.scores.find_or_initialize_by(api: 'omdb', source: source)
          score.assign_attributes(score_params(page).merge(source: source))
          score.similarity = similarity
          score.save
        end
      end

      def unscored_movies
        Movie.order('movies.last_avaliation').limit(800)
      end

      def movies_query
        %(SELECT scores.*,
                movies.title,
                movies.genres
        FROM (
            SELECT DISTINCT "scores".scorable_id,
                            sum(replace(scores.votes,',','')::NUMERIC) AS votes,
                            avg(cast(scores.rating AS DOUBLE precision)) AS ratings,
                            max(LANGUAGE) AS LANGUAGE,
                            max(country) AS country,
                            max(poster) AS poster

            FROM "scores"
            WHERE "scores"."rating" <> 'N/A' AND
                  "scores"."votes" <> 'N/A' AND
                  scores.scorable_type = 'Movie'

            GROUP BY scorable_type, scorable_id
        ) AS scores

        INNER JOIN movies ON movies.id = scores.scorable_id

        WHERE scores.votes > 2000
        ORDER BY scores.ratings DESC)
      end

      def genres(movie, page)
        movie.genres | page.fetch('Genre').split(', ')
      end

      def score_params(page)
        page.slice(
          'Title',
          'Year',
          'Released',
          'Director',
          'Writer',
          'Language',
          'Country',
          'Poster',
          'Source'
        ).merge(
          api:      'omdb',
          rating:   page.fetch('imdbRating'),
          sourceid: page.fetch('imdbID'),
          votes:    page.fetch('imdbVotes')
        ).transform_keys!(&:downcase)
      end

      def build_similarity(movie, page)
        page_year = page.fetch('Year').split('-').first
        if (movie.year.to_i.abs - page_year.to_i.abs).abs > 1
          return 0
        end
        "#{movie.title} #{movie.year}".similar("#{page.fetch('Title')} #{page_year}")
      end
    end
  end
end

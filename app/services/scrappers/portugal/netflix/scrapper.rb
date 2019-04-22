module Scrappers
  module Portugal
    module Netflix
      class Scrapper < Scrappers::Base

        attr_accessor :movies_url, :platform

        def initialize
          @platform =     'netflix-pt'
          @movies_url =   'https://www.finder.com/pt/netflix-movies'
          @tv_shows_url = 'https://www.finder.com/pt/netflix-tv-shows'
        end

        def backup_db
          exec("pg_dump -Fc cartaz_development > cartaz_#{Time.zone.now.iso8601}.dump")
        end

        def run
          proccess_movies!
        end

        private

        def proccess_movies!
          ActiveRecord::Base.transaction do
            Movie.all.select(:id, :platforms, :deleted_at).each do |movie|
              movie.update_columns(platforms: movie.platforms - [platform])
            end

            page = parse(movies_url)
            page.css('table.ts-table tbody tr').each do |row|
              movie = Movie.unscoped.find_or_initialize_by(title: title(row), year: year(row))
              if movie.persisted?
                update(movie, row)
              else
                movie.assign_attributes(create_params(row))
                movie.save
              end
            end
          end
        end

        def create_params(row)
          { runtime:    runtime(row),
            title:      title(row),
            year:       year(row),
            genres:     genres(row),
            platforms:  [platform],
            last_scrap: Time.zone.now,
            deleted_at: nil }
        end

        def title(row)
          row.css('td[data-title="Title"] b').text
        end

        def year(row)
          row.css('td[data-title="Year of release"]').text
        end

        def runtime(row)
          row.css('td[data-title="Runtime (mins)"]').text
        end

        def genres(row)
          (row.css('td[data-title="Genres"]').text.split(' ') - ['&']).map(&:singularize)
        end
      end
    end
  end
end

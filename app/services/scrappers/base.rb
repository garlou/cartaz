require 'net/http'
require 'uri'

module Scrappers
  class Base

    private

    def parse(url)
      Nokogiri::HTML(open(url))
    end

    def parse_json(url)
      JSON.parse(open(url))
    end

    def open(url)
      Net::HTTP.get(URI.parse(url))
    end

    def update(movie, row)
      movie.update(runtime:    runtime(row),
                   genres:     genres_for(movie, row),
                   platforms:  movie.platforms | [platform],
                   last_scrap: Time.zone.now,
                   deleted_at: nil)
    end

    def genres_for(movie, row)
      genres = (movie.genres | genres(row)) - ['&']
      genres.map(&:singularize)
      # genres.each do |genre|
      #   Genre.find_or_create_by(genre: genre, platform: platform)
      # end
    end
  end
end

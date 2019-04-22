module Avaliators
  module RottenTomatoes
    class Avaliator < Scrappers::Base

      attr_accessor :url

      def initialize
        @url = 'https://www.rottentomatoes.com/search/?search='
      end

      # google api key = AIzaSyC1wJdJ9bxLLCLZxUyDOMOlOc83xXsbylI
      # 003204420339293036846:evxod2mfkvo
      # https://www.googleapis.com/customsearch/v1?key=AIzaSyC1wJdJ9bxLLCLZxUyDOMOlOc83xXsbylI&cx=003204420339293036846:evxod2mfkvo&q=rottent%20tomatoes%20A%20Christmas%20Prince%202017

      def run
        page = parse("#{url}#{URI.encode('A Christmas Prince')}")
        binding.pry
        page.css('#movieSection .results_ul li:first-child').each do |row|
          # movie = Movie.find_or_initialize_by(title: title(row), year: year(row))
          # if movie.persisted?
          #   movie.update(update_params(row))
          #   update(movie, row)
          # else
          #   movie.assign_attributes(create_params(row))
          #   movie.save
          # end
        end
      end

      private

    end
  end
end

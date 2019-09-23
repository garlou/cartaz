# frozen_string_literal: true

module Query
  class FetchScoredMovies
    class << self
      include Concerns::Scorable

      def call(args)
        page = args.fetch(:page, 1)
        per_page = 10
        offset = ((page - 1) * per_page) + (page - 1)
        Movie.find_by_sql("#{sql}#{order(offset, per_page)}")
      end
    end
  end
end

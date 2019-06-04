# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :scores, [Types::ScoreType], null: false do
      argument :page, Integer, required: false
      argument :order, String, required: false
      argument :column, String, required: false
    end

    field :total_movies, Int, null: false

    def scores(args = {})
      Query::FetchScoredMovies.(args)
    end
    
    def total_movies
      Query::FetchTotalMovies.call
    end
  end
end

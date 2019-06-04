module Types
  class ScoreType < Types::BaseObject
    graphql_name 'ScoreType'

  	field :scorable_id,                    ID, null: true
  	field :title,                 String, null: true
    field :year,                  String, null: false
    field :votes,               Float, null: true
    field :genres,                [String], null: true
    field :platforms,             [String], null: true
    field :poster,             String, null: true
    field :country,             String, null: true
    field :language,             String, null: true
    field :ratings,             String, null: true
  end
end
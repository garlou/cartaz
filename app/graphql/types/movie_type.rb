# # frozen_string_literal: true

# Types::MovieType = GraphQL::ObjectType.define do
#   name 'Movie'

#   field :id,                    !types.ID
#   field :title,                 !types.String
#   field :year,                  types.String
#   field :runtime,               types.String
#   field :genres,                types[types.String]
#   field :platforms,             types[types.String]
# end

module Types
  class MovieType < Types::BaseObject
    graphql_name 'MovieType'

  	field :id,                    ID, null: true
  	field :title,                 String, null: true
    field :year,                  String, null: false
    field :runtime,               String, null: true
    field :genres,                [String], null: true
    field :platforms,             [String], null: true
  end
end
Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :movies, !types[Types::MovieType] do
    argument :id, types.ID
    argument :title, types.String
    argument :year, types.String
    argument :runtime, types.String

    resolve -> (obj, args, ctx) {
      Movie.all
    }
  end
end
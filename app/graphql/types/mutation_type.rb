Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  # field :signInUser,          function: Mutations::Auth::SignInUser.new
  # field :createParticipation, function: Mutations::Participations::CreateParticipation.new
  # field :createAnswer,        function: Mutations::Participations::CreateAnswer.new
  # field :createExtraAnswer,   function: Mutations::Participations::CreateExtraAnswer.new
  # field :createExtraAnswers,  function: Mutations::Participations::CreateExtraAnswers.new
  # field :finishParticipation, function: Mutations::Participations::FinishParticipation.new
end

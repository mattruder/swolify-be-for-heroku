module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :create_game, mutation: Mutations::CreateGame
  end
end

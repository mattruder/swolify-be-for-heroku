module Types
  class MutationType < Types::BaseObject
    field :modify_game, mutation: Mutations::ModifyGame  
    field :create_game, mutation: Mutations::CreateGame
  end
end

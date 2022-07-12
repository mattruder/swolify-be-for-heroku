module Mutations
  class ModifyGame < Mutations::BaseMutation
    argument :params, Types::Input::GameInputType, required: true

    field :game, Types::GameType, null: false

    def resolve(params:)
      game = Game.find(params[:id])
      if game.update(win: params[:win])
        {
          game: game,
          errors: []
        }
      else
        {
          game: nil,
          errors: game.errors.full_messages
        }
      end
    end
  end
end

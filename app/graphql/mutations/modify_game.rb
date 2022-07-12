class Mutations::ModifyGame < Mutations::BaseMutation
  argument :params, Types::Input::GameInputType, required: true

  field :game, Types::GameType, null: false

  def resolve(params:)
    game = Game.find(params[:id])
    if game.update(win: params[:win])
      {
        game: game
      }
    end
  rescue ActiveRecord::RecordNotFound => _e
    GraphQL::ExecutionError.new("Game does not exist")
  end
end

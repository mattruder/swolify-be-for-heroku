class Mutations::ModifyGame < Mutations::BaseMutation
  argument :params, Types::Input::GameInputType, required: true

  field :game, Types::GameType, null: true
  field :success, Boolean, null: false

  def resolve(params:)
    game = Game.find(params[:id])
    if game.update(win: params[:win])
      game.complete_game_activities(params[:activities])
      {
        game: game,
        success: true
      }
    end
  rescue ActiveRecord::RecordNotFound => _e
    GraphQL::ExecutionError.new("Game does not exist")
  end
end

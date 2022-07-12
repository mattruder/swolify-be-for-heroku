class Mutations::CreateGame < Mutations::BaseMutation
  argument :params, Types::Input::NewGameInputType, required: true

  field :game, Types::GameType, null: false
  field :errors, [String], null: false

  def resolve(params:)
    game = Game.new(level: params[:level], user_id: params[:user_id])
    if game.save
      game.add_activities(params[:categories])
      {
        game: game,
        errors: nil
      }
    else
      {
        game: nil,
        errors: game.errors.full_messages
      }
    end
  end
end

class Mutations::CreateGame < Mutations::BaseMutation
  argument :params, Types::Input::NewGameInputType, required: true

  field :game, Types::GameType, null: true
  field :errors, [String], null: true

  def resolve(params:)
    game = Game.new(level: params[:level], user_id: params[:user_id])
    if game.categories_present?(params[:categories]) && game.save
      game.add_activities(params[:categories])
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

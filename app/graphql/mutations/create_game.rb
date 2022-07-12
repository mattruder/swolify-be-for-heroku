class Mutations::CreateGame < Mutations::BaseMutation
  argument :level, String, required: true
  argument :user_id, Integer, required: true
  argument :categories, [String], required: true

  field :game, Types::GameType, null: false
  field :errors, [String], null: false
  # require "pry"; binding.pry

  def resolve(level:, user_id:, categories:)
    game = Game.new(level: level, user_id: user_id)
    if game.save
      game.add_activities(categories)
    else
      {
        game: nil,
        errors: game.errors.full_messages
      }
    end
  end
end

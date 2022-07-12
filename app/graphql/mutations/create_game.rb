class Mutations::CreateGame < Mutations::BaseMutation
  argument :level, String, required: true
  argument :user_id, Integer, required: true
  argument :categories, [String], required: true

  field :game Types::GameType, null: false
  field :errors, [String], null: false

  def resolve(level:, user_id:)
    game = Game.new(level: level, user_id: user_id)
    require "pry"; binding.pry
  end
end

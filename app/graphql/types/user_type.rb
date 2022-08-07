module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :email, String, null: true
    field :wins, Integer, null: true
    field :losses, Integer, null: true
    field :game_count, Integer, null: true
    field :games, [Types::GameType], null: true
    field :activity_count, Integer, null: true
    field :days_in_current_active_streak, Integer, null: true
    field :days_longest_streak, Integer, null: true
    field :activities, [Types::ActivityType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end

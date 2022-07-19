module Types
  class GameType < Types::BaseObject
    field :id, ID, null: false
    field :win, Boolean, null: true
    field :user_id, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :completed_activities, [Types::ActivityType], null: false
    field :level, String, null: true
    field :activities, [Types::ActivityType], null: true
    field :game_activities, [Types::GameActivityType], null: true
  end
end

module Types
  class GameActivityType < Types::BaseObject
    field :id, ID, null: false
    field :activity_id, Integer, null: true
    field :game_id, Integer, null: true
    field :completed, Boolean, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :activity, Types::ActivityType, null: true
  end
end

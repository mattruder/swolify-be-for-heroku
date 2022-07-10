module Types
  class GameType < Types::BaseObject
    field :id, ID, null: false
    field :win, Boolean, null: true
    field :user_id, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :level, Integer, null: true
  end
end

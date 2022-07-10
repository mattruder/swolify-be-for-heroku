module Types
  class ActivityType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :category, Integer, null: true
    field :duration, String, null: true
    field :video, String, null: true
    field :description, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end

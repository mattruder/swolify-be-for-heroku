module Queries
  class FetchUser < Queries::BaseQuery
    type Types::UserType, null:false
    argument :id, ID, required: true

    def resolve(id:)
      user = User.find(id)
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new("User does not exist")
    end
  end
end
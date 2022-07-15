module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :fetch_user, resolver: Queries::FetchUser
    field :fetch_all_users, resolver: Queries::FetchAllUsers
  end
end

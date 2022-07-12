module Types
  module Input
    class NewGameInputType < Types::BaseInputObject
      argument :level, String, required: true
      argument :user_id, Integer, required: true
      argument :categories, [String], required: true
    end
  end
end

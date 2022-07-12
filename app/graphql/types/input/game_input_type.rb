module Types
  module Input
    class GameInputType < Types::BaseInputObject
      argument :id, Integer, required: true
      argument :activities, [String], required: true
      argument :win, Boolean, required: true
    end
  end
end

module Types
  module Input
    class GameInputType < Types::BaseInputObject
      argument :id, Integer, required: true
      argument :activities, [Integer], required: true
      argument :win, Boolean, required: true
    end
  end
end

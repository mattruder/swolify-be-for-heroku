require 'rails_helper'

RSpec.describe 'create game mutation' do
  let!(:user) { User.create!(name: "Susan", email: "susan@email.com") }
  let!(:upper_body_activities) { create_list(:activity, 16, category: 0) }
  let!(:lower_body_activities) { create_list(:activity, 16, category: 1) }
  let!(:core_activities) { create_list(:activity, 16, category: 2) }
  let!(:cardio_activities) { create_list(:activity, 16, category: 3) }

  describe 'create a game' do
    it 'creates a game' do
      level = "easy"
      categories = ["core", "upper body"]
      mutation = <<~GQL
      mutation {
        createGame {
          user_id: #{user.id}
          level: #{level}
          categories: #{categories}
        }
      }
      GQL

      result = SwolifyBeSchema.execute(mutation)
      require "pry"; binding.pry
    end
  end
end

require 'rails_helper'
module Mutations
  module Games

RSpec.describe CreateGame, type: :request do
  let!(:user) { User.create!(name: "Susan", email: "susan@email.com") }
  let!(:upper_body_activities) { create_list(:activity, 16, category: 0) }
  let!(:lower_body_activities) { create_list(:activity, 16, category: 1) }
  let!(:core_activities) { create_list(:activity, 16, category: 2) }
  let!(:cardio_activities) { create_list(:activity, 16, category: 3) }

  let!(:level) { "easy" }
  let!(:categories) {["core", "upper body"]}

  describe '.resolve' do
    it 'creates a game' do
      # level = "easy"
      # categories = ["core", "upper body"]
      # input = {
      #   userId: user.id,
      #   level: level,
      #   categories: categories
      # }

      post "/graphql", params: {query: query}
      require "pry"; binding.pry
      json = JSON.parse(response.body, symbolize_names: true)

      # require "pry"; binding.pry
      # result = SwolifyBeSchema.execute(mutation)
      # require "pry"; binding.pry
    end

    def query
      <<~GQL
      mutation {
        createGame(input: {
          userId: "#{user.id}",
          level: "#{level}",
          categories: "#{categories}"
          })
        {
          game {
            level
          }
        errors
        }
      }
      GQL
    end

  end
end
end
end

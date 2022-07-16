require 'rails_helper'

describe 'createGame mutation', type: :request do
  let!(:user) { User.create!(name: "Susan", email: "susan@email.com") }
  let!(:upper_body_activities) { create_list(:activity, 16, category: 0) }
  let!(:lower_body_activities) { create_list(:activity, 16, category: 1) }
  let!(:core_activities) { create_list(:activity, 16, category: 2) }
  let!(:cardio_activities) { create_list(:activity, 16, category: 3) }
  let!(:free_activity) { Activity.create!(name: "Free space", description: "free space", video: "free@video", category: "free", duration: "free") } 

  describe '.resolve' do
    it 'creates an easy game with 9 unique activities' do
      level = "easy"
      categories = ["core", "upper body"]
      query = <<~GQL
      mutation {
        createGame(input: {params: {
          userId: #{user.id},
          level: "#{level}",
          categories: #{categories}
          }})
        {
        game {
          userId
          gameActivities{
            id
            activity {
              name
              description
              duration
              video
              }
            }
          }
        }
      }
      GQL

      result = SwolifyBeSchema.execute(query)

      expect(result.dig("data", "createGame", "game", "userId")).to eq(user.id)
      expect(result.dig("data", "createGame", "game", "gameActivities").count).to eq(9)

      activity_names = result.dig("data", "createGame", "game", "gameActivities").map {|act| act.dig("activity", "name")}

      expect(activity_names.uniq).to eq(activity_names)
    end

    it 'creates a hard game with 16 unique activities' do
      level = "hard"
      categories = ["cardio", "lower body"]
      query = <<~GQL
      mutation {
        createGame(input: {params: {
          userId: #{user.id},
          level: "#{level}",
          categories: #{categories}
          }})
        {
        game {
          userId
          gameActivities{
            id
            activity {
              name
              description
              duration
              video
              }
            }
          }
        }
      }
      GQL

      result = SwolifyBeSchema.execute(query)

      expect(result.dig("data", "createGame", "game", "userId")).to eq(user.id)
      expect(result.dig("data", "createGame", "game", "gameActivities").count).to eq(16)

      activity_names = result.dig("data", "createGame", "game", "gameActivities").map {|act| act.dig("activity", "name")}

      expect(activity_names.uniq).to eq(activity_names)
    end
  end
end

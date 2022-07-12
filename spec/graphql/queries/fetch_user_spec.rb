require 'rails_helper'

RSpec.describe 'user query' do
  it 'returns the user by id' do
    user_1 = User.create!(name: "Andrew", email: "andrew@turing.edu")
    user_2 = User.create!(name: "Carl", email: "carl@turing.edu")
    
    query = <<~GQL
    query {
      fetchUser(id: #{user_1.id}) {
        name
        email
        activities {
          name
        }
      }
    }
    GQL
    result = SwolifyBeSchema.execute(query)

    expect(result.dig("data", "fetchUser", "name")).to eq("Andrew")
  end

  it 'returns the user by id and their activities' do
    user_1 = User.create!(name: "Andrew", email: "andrew@turing.edu")
    a_game = Game.create!(user_id: user_1.id, level: 0)
    pushups = Activity.create!(name: "pushups", category: "upper body", duration: "10 reps", video: "video.com", description: "push the earth down")
    a_game_activity = GameActivity.create!(game_id: a_game.id, activity_id: pushups.id)
    
    user_2 = User.create!(name: "Carl", email: "carl@turing.edu")
    c_game = Game.create!(user_id: user_2.id, level: 0)
    situps = Activity.create!(name: "situps", category: "upper body", duration: "10 reps", video: "video.com", description: "push the earth down")
    c_game_activity = GameActivity.create!(game_id: c_game.id, activity_id: situps.id)
    
    query = <<~GQL
    query {
      fetchUser(id: #{user_1.id}) {
        name
        email
        activities {
          name
        }
      }
    }
    GQL
    result = SwolifyBeSchema.execute(query)

    expect(result.dig("data", "fetchUser", "activities").count).to eq(1)
    expect(result.dig("data", "fetchUser", "activities").first["name"]).to eq("pushups")
  end

  it "returns an error if user is not found" do
    user_1 = User.create!(name: "Andrew", email: "andrew@turing.edu")
    
    query = <<~GQL
    query {
      fetchUser(id: 42) {
        name
        email
        activities {
          name
        }
      }
    }
    GQL

    result = SwolifyBeSchema.execute(query)

    expect(result).to have_key("errors")
    expect(result.dig("errors").first["message"]).to eq("User does not exist")
  end
end
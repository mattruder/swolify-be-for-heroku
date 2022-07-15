require 'rails_helper'

RSpec.describe 'user query' do
  let!(:free_activity) { Activity.create!(name: "Free space", description: "free space", video: "free@video", category: "free", duration: "free") }

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

    expect(result.dig("data", "fetchUser", "activities").count).to eq(2)
    expect(result.dig("data", "fetchUser", "activities")[1]["name"]).to eq("pushups")
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

  it "returns the user's wins and losses" do
    user_1 = User.create!(name: "Andrew", email: "andrew@turing.edu")
    game_win_1 = Game.create!(win: true, user_id: user_1.id, level: 0)
    game_win_2 = Game.create!(win: true, user_id: user_1.id, level: 0)
    game_lose = Game.create!(user_id: user_1.id, level: 0)

    query = <<~GQL
    query {
      fetchUser(id: #{user_1.id}) {
        name
        email
        wins
        losses
        activities {
          name
        }
      }
    }
    GQL

    result = SwolifyBeSchema.execute(query)

    expect(result.dig("data", "fetchUser", "wins")).to eq(2)
    expect(result.dig("data", "fetchUser", "losses")).to eq(1)
  end

  it "returns the user's game count" do
    user_1 = User.create!(name: "Andrew", email: "andrew@turing.edu")
    game_win_1 = Game.create!(win: true, user_id: user_1.id, level: 0)
    game_win_2 = Game.create!(win: true, user_id: user_1.id, level: 0)
    game_lose = Game.create!(user_id: user_1.id, level: 0)

    user_2 = User.create!(name: "Carl", email: "carl@turing.edu")
    carl_game = Game.create!(user_id: user_2.id, level: 1)

    query = <<~GQL
    query {
      fetchUser(id: #{user_1.id}) {
        name
        email
        wins
        losses
        gameCount
        activities {
          name
        }
      }
    }
    GQL

    result = SwolifyBeSchema.execute(query)

    expect(result.dig("data", "fetchUser", "gameCount")).to eq(3)
  end

  it "returns the user's activity count" do
    user_1 = User.create!(name: "Andrew", email: "andrew@turing.edu")
    game_win_1 = Game.create!(win: true, user_id: user_1.id, level: 0)
    game_win_2 = Game.create!(win: true, user_id: user_1.id, level: 0)
    game_lose = Game.create!(user_id: user_1.id, level: 0)
    game_win_1.activities.create!(name: "pushups", category: "upper body", duration: "10 reps", video: "video.com", description: "push the earth down")
    game_win_1.activities.create!(name: "situps", category: "lower body", duration: "10 reps", video: "video.com", description: "push the earth down")

    user_2 = User.create!(name: "Carl", email: "carl@turing.edu")
    carl_game = Game.create!(user_id: user_2.id, level: 1)
    carl_game.activities.create!(name: "climb the chair", category: "upper body", duration: "forever", video: "video.com", description: "tear up the chair")

    query = <<~GQL
    query {
      fetchUser(id: #{user_1.id}) {
        name
        email
        wins
        losses
        gameCount
        activityCount
        activities {
          name
        }
      }
    }
    GQL

    result = SwolifyBeSchema.execute(query)

    expect(result.dig("data", "fetchUser", "activityCount")).to eq(5) #accounts for free spaces for all games
  end
end

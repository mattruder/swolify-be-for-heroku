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
    user = User.create!(name: "Tony Soprano", email: "who_ate_all_the_gabagool@sopranos.net")
    game = user.games.create!(level: 0)
    activity_1 = Activity.create!(name: "Push Ups", category: 0, duration: "25 reps", video: "testurl.com/push_ups", description: "do push ups")
    activity_2 = Activity.create!(name: "Pull Ups", category: 0, duration: "10 reps", video: "testurl.com/pull_ups", description: "do pull ups")
    activity_3 = Activity.create!(name: "Sit Ups", category: 2, duration: "30 reps", video: "testurl.com/sit_ups", description: "do sit ups")
    activity_4 = Activity.create!(name: "Plank", category: 2, duration: "2 minutes", video: "testurl.com/plank", description: "do a plank")
    activity_5 = Activity.create!(name: "Jumping Jacks", category: 3, duration: "50 reps", video: "testurl.com/jumping_jacks", description: "do jumping jacks")
    activity_6 = Activity.create!(name: "Burpees", category: 3, duration: "25 reps", video: "testurl.com/burpees", description: "do burpees")
    activity_7 = Activity.create!(name: "Chin Ups", category: 0, duration: "10", video: "testurl.com/chin_ups", description: "do chin ups")
    activity_8 = Activity.create!(name: "Back Extensions", category: 1, duration: "15 reps", video: "testurl.com/back_extensions", description: "do back extensions")
    activity_9 = Activity.create!(name: "Wall Sits", category: 3, duration: "2 minutes", video: "testurl.com/wall_sits", description: "do wall sits")
    activity_10 = Activity.create!(name: "BW Squats", category: 1, duration: "50 reps", video: "testurl.com/bw_squats", description: "do body weight squats")
    game_activity_1 = game.game_activities.create!(activity: activity_1, completed: true)
    game_activity_2 = game.game_activities.create!(activity: activity_3, completed: true)
    game_activity_3 = game.game_activities.create!(activity: activity_5)
    game_activity_4 = game.game_activities.create!(activity: activity_6)
    game_activity_5 = game.game_activities.create!(activity: activity_9)
    game_activity_6 = game.game_activities.create!(activity: activity_10)
    
    query = <<~GQL
    query {
      fetchUser(id: #{user.id}) {
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

    expect(result.dig("data", "fetchUser", "activityCount")).to eq(2)
  end
end
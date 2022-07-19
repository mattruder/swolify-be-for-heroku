require "rails_helper"

describe "modifyGame mutation", type: :request do
  let!(:free_activity) { Activity.create!(name: "Free space", description: "free space", video: "free@video", category: "free", duration: "free") }

  describe "resolve" do
    it "updates a games win boolean and updates the specified game activities to completed" do
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
      game_activity_1 = game.game_activities.create!(activity: activity_1)
      game_activity_2 = game.game_activities.create!(activity: activity_3)
      game_activity_3 = game.game_activities.create!(activity: activity_5)
      game_activity_4 = game.game_activities.create!(activity: activity_6)
      game_activity_5 = game.game_activities.create!(activity: activity_9)
      game_activity_6 = game.game_activities.create!(activity: activity_10)

      expect(game.win).to eq(false)

      query = <<~GQL
        mutation {
          modifyGame(input: { params: { id: #{game.id}, win: true, activities: [#{game_activity_2.id}, #{game_activity_3.id}, #{game_activity_5.id}, #{game_activity_6.id}]}}) {
            game {
              id
              win
              level
            }
          }
        }
      GQL

      result = SwolifyBeSchema.execute(query)

      expect(result.dig("data", "modifyGame", "game", "win")).to eq(true)
      expect(Game.find(game.id).win).to eq(true)
      expect(GameActivity.find(game_activity_1.id).completed).to eq(false)
      expect(GameActivity.find(game_activity_2.id).completed).to eq(true)
      expect(GameActivity.find(game_activity_3.id).completed).to eq(true)
      expect(GameActivity.find(game_activity_4.id).completed).to eq(false)
      expect(GameActivity.find(game_activity_5.id).completed).to eq(true)
      expect(GameActivity.find(game_activity_6.id).completed).to eq(true)
    end

    it "returns an error if the game is not found by id" do
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
      game_activity_1 = game.game_activities.create!(activity: activity_1)
      game_activity_2 = game.game_activities.create!(activity: activity_3)
      game_activity_3 = game.game_activities.create!(activity: activity_5)
      game_activity_4 = game.game_activities.create!(activity: activity_6)
      game_activity_5 = game.game_activities.create!(activity: activity_9)
      game_activity_6 = game.game_activities.create!(activity: activity_10)

      query = <<~GQL
        mutation {
          modifyGame(input: { params: { id: 99999999, win: true, activities: ["Sit Ups", "Jumping Jacks", "Wall Sits", "BW Squats"]}}) {
            game {
              id
              win
              level
            }
          }
        }
      GQL

      result = SwolifyBeSchema.execute(query)

      expect(result).to have_key("errors")
      expect(result.dig("errors").first["message"]).to eq("Game does not exist")
      expect(GameActivity.find(game_activity_1.id).completed).to eq(false)
      expect(GameActivity.find(game_activity_2.id).completed).to eq(false)
      expect(GameActivity.find(game_activity_3.id).completed).to eq(false)
      expect(GameActivity.find(game_activity_4.id).completed).to eq(false)
      expect(GameActivity.find(game_activity_5.id).completed).to eq(false)
      expect(GameActivity.find(game_activity_6.id).completed).to eq(false)
    end
  end
end

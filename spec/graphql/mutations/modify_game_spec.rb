require "rails_helper"

describe "modifyGame mutation", type: :request do
  describe "resolve" do
    it "updates a games win boolean" do
      user = User.create!(name: "Tony Soprano", email: "who_ate_all_the_gabagool@sopranos.net")
      game = user.games.create!(level: 0)

      expect(game.win).to eq(false)

      query = <<~GQL
        mutation {
          modifyGame(input: { params: { id: #{game.id}, win: true }}) {
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
    end

    it "returns an error if the game is not found by id" do
      user = User.create!(name: "Tony Soprano", email: "who_ate_all_the_gabagool@sopranos.net")
      game = user.games.create!(level: 0)

      query = <<~GQL
        mutation {
          modifyGame(input: { params: { id: 9999999999, win: true }}) {
            game {
              id
              win
              level
            }
          }
        }
      GQL

      result = SwolifyBeSchema.execute(query)
      binding.pry
      expect(result.dig("data", "modifyGame", "game", "win")).to eq(true)
    end
  end
end

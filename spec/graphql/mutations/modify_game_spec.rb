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
    end
  end
end

require "rails_helper"

module Mutations
  module Games
    describe ModifyGame, type: :request do
      describe "resolve" do
        it "updates a games win boolean" do
          user = User.create!(name: "Tony Soprano", email: "who_ate_all_the_gabagool@sopranos.net")
          game = user.games.create!(level: 0)

          post "/graphql", params: {query: query(id: game.id)}

          response_body = JSON.parse(response.body, symbolize_names: true)
          data = response_body[:data][:modifyGame]

          expect(data).to include(
            id: game.id,
            win: true,
            user_id: user.id,
            level: 0
          )
        end
      end

      def query(id)
        <<~GQL
          mutation {
            modifyGame(
              id: #{id},
              win: true,
            ) {
              id
              win
              level
              user {
                id
              }
            }
          }
        GQL
      end
    end
  end
end

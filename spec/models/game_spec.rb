require "rails_helper"

describe Game do
  describe "relationships" do
    it { should belong_to :user }
    it { should have_many :game_activities }
    it { should have_many(:activities).through(:game_activities) }
  end

  describe "validations" do
    it "should be created with a default win value of false" do
      user = User.create!(name: "Tony Soprano", email: "who_ate_all_the_gabagool@sopranos.net")
      game = user.games.create!

      expect(game.win).to eq(false)
    end
  end
end

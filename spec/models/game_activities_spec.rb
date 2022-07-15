require "rails_helper"

describe GameActivity do
  let!(:free_activity) { Activity.create!(name: "Free space", description: "free space", video: "free@video", category: "free", duration: "free") }
  
  describe "relationships" do
    it { should belong_to :game }
    it { should belong_to :activity }
    it { should have_one(:user).through(:game) }
  end

  describe "validations" do
    it "should be created with a default completed value of false" do
      user = User.create!(name: "Tony Soprano", email: "who_ate_all_the_gabagool@sopranos.net")
      game = user.games.create!(level: 0)
      activity = Activity.create!(name: "Push Ups", duration: "25 reps", category: 0, video: "test_url.com", description: "do a push up")
      game_activity = game.game_activities.create!(activity: activity)

      expect(game_activity.completed).to eq(false)
    end
  end
end

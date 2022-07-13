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
      game = user.games.create!(level: 0)

      expect(game.win).to eq(false)
    end

    it { should validate_presence_of :level }
  end

  describe "instance methods" do
    let!(:user) { User.create!(name: "Nick Miller", email: "juliuspepperwood@the_loft.com")}

    it '#activity_num' do
      easy_game = Game.create!(user: user, level: "easy")
      hard_game = Game.create!(user: user, level: "hard")

      expect(easy_game.activity_num).to eq(9)
      expect(hard_game.activity_num).to eq(16)
    end

    it '#unique_activity' do
      core_activities = create_list(:activity, 5, category: 2)
      cardio_activities = create_list(:activity, 5, category: 3)

      game = Game.create!(user: user, level: "easy")

      10.times do
        game.unique_activity(["core", "cardio"])
      end

      expect(game.activities.uniq).to eq(game.activities)
    end

    it '#add_activities' do
      easy_game = Game.create!(user: user, level: "easy")
      hard_game = Game.create!(user: user, level: "hard")

      core_activities = create_list(:activity, 16, category: 2)
      cardio_activities = create_list(:activity, 16, category: 3)

      easy_game.add_activities(["core"])
      hard_game.add_activities(["cardio", "core"])

      easy_core = easy_game.activities.select {|act| act.core?}
      easy_cardio = easy_game.activities.select {|act| act.cardio?}
      hard_core = hard_game.activities.select {|act| act.core?}
      hard_cardio = hard_game.activities.select {|act| act.cardio?}

      expect(easy_game.activities.count).to eq(9)
      expect(hard_game.activities.count).to eq(16)
      expect(easy_core.count).to eq(9)
      expect(easy_cardio.count).to eq(0)
      expect(hard_core.count).to eq(8)
      expect(hard_cardio.count).to eq(8)
    end
  end
end

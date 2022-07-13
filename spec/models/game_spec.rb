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


end

require "rails_helper"

describe User do
  describe "relationships" do
    it { should have_many :games }
    it { should have_many(:game_activities).through(:games) }
    it { should have_many(:activities).through(:game_activities) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end
end

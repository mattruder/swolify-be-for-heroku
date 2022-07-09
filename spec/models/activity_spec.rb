require "rails_helper"

describe Activity do
  describe "relationships" do
    it { should have_many :game_activities }
    it { should have_many(:games).through(:game_activities) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :duration }
    it { should validate_presence_of :video }
    it { should validate_presence_of :description }
  end
end

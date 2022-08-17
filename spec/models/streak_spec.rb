require 'rails_helper'

RSpec.describe Streak, type: :model do
  describe 'relationships' do
    it { should belong_to (:user) }
  end

  describe 'validations' do
    # it { should validate_inclusion_of(:active).in_array([true, false]) }
    it { should validate_presence_of :days_in_a_row }
    it 'default value of true for active attribute and 1 day in a row' do
      user = User.create!(name: "Tony Soprano", email: "who_ate_all_the_gabagool@sopranos.net")
      streak = Streak.create!(user_id: user.id)

      expect(streak.active).to be true
      expect(streak.days_in_a_row).to eq(1)
    end
  end

  describe 'instance methods' do
    let!(:user) { User.create!(name: "Tony Soprano", email: "who_ate_all_the_gabagool@sopranos.net") }

    it '#increase_by_one' do
      streak = Streak.create!(created_at: Date.yesterday, updated_at: Date.yesterday, user_id: user.id)
      streak.increase_by_one
      expect(streak.days_in_a_row).to eq(2)
    end

    it '#not_updated_yet_today' do
      yesterdays_streak = Streak.create!(created_at: Date.yesterday, updated_at: Date.yesterday, user_id: user.id)
      todays_streak = Streak.create!(user_id: user.id)
      
      expect(yesterdays_streak.not_updated_yet_today).to eq(true)
      expect(todays_streak.not_updated_yet_today).to eq(false)

      yesterdays_streak.increase_by_one
      expect(yesterdays_streak.not_updated_yet_today).to eq(false)
    end
  end
end

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
end

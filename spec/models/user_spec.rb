require "rails_helper"

describe User do
  describe "relationships" do
    it { should have_many :games }
    it { should have_many(:game_activities).through(:games) }
    it { should have_many(:activities).through(:game_activities) }
    it { should have_many(:streaks) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end

  describe 'instance methods' do
    let!(:user) { User.create!(name: "Nick Miller", email: "juliuspepperwood@the_loft.com")}
    let!(:user_2) { User.create!(name: "Tony Soprano", email: "who_ate_all_the_gabagool@sopranos.net")}

    describe 'update_or_create_streak' do
      it 'creates a new streak when it has no active ones' do
        3.times { user.streaks.create!(active: false) }

        expect(user.streaks.count).to eq(3)

        user.update_or_create_streak

        expect(user.streaks.count).to eq(4)
      end

      it 'adds a day to an existing streak if one is active' do
        streak = user.streaks.create!(created_at: Date.yesterday, updated_at: Date.yesterday, active: true)
        expect(streak.days_in_a_row).to eq(1)

        user.update_or_create_streak

        expect(user.streaks.count).to eq(1)
        expect(Streak.find(streak.id).days_in_a_row).to eq(2)
      end

      it 'only can add one day once each day' do
        streak = user.streaks.create!(active: true)
        new_count = streak.days_in_a_row + 1
        streak.update(days_in_a_row: new_count)
        expect(Streak.find(streak.id).days_in_a_row).to eq(2)
        user.update_or_create_streak
        expect(Streak.find(streak.id).days_in_a_row).to eq(2)
      end
    end

    it 'days_in_current_active_streak' do
      streak_1 = user.streaks.create!(active: false, days_in_a_row: 4)
      streak_2 = user.streaks.create!(active: false, days_in_a_row: 8)
      streak_3 = user.streaks.create!(active: true, days_in_a_row: 5)

      expect(user.days_in_current_active_streak).to eq(5)
      streak_4 = user_2.streaks.create!(active: false, days_in_a_row: 3)
      expect(user_2.days_in_current_active_streak).to eq(0)
    end

    it 'days_in_longest_streak' do
      streak_1 = user.streaks.create!(active: false, days_in_a_row: 4)
      streak_2 = user.streaks.create!(active: false, days_in_a_row: 8)
      streak_3 = user.streaks.create!(active: true, days_in_a_row: 5)

      expect(user.days_in_longest_streak).to eq(8)
      expect(user_2.days_in_longest_streak).to eq(0)
    end
  end
end

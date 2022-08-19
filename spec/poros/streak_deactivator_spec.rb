require 'rails_helper'

RSpec.describe StreakDeactivator do
  let!(:susan) { User.create!(name: "Susan", email: "susan@email.com") }
  let!(:andrew) { User.create!(name: "Andrew", email: "andrew@email.com") }
  let!(:james) { User.create!(name: "James", email: "james@email.com") }
  # let!(:day_1) { Date.yesterday }
  # let!(:day_2) { day_1.yesterday }
  let!(:streak1) { susan.streaks.create(active: false)}
  let!(:streak2) { susan.streaks.create(active: true, updated_at: 10.hours.ago)}
  let!(:streak3) { andrew.streaks.create(active: false)}
  let!(:streak4) { andrew.streaks.create(active: false)}
  let!(:streak5) { andrew.streaks.create(active: true, updated_at: 2.days.ago)}
  let!(:streak6) { james.streaks.create(active: true, updated_at: 27.hours.ago)}

  it 'old_streaks' do
    expect(StreakDeactivator.old_streaks).to eq([streak5, streak6])
    expect(StreakDeactivator.old_streaks.count).to eq(2)
  end

  it 'inactivate_old_streaks' do
    expect(Streak.find(streak2.id).active).to be true
    expect(Streak.find(streak5.id).active).to be true
    expect(Streak.find(streak6.id).active).to be true

    StreakDeactivator.inactivate_old_streaks

    expect(Streak.find(streak2.id).active).to be true
    expect(Streak.find(streak5.id).active).to be false
    expect(Streak.find(streak6.id).active).to be false
  end
end

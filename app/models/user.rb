class User < ApplicationRecord
  has_many :games, dependent: :destroy
  has_many :streaks, dependent: :destroy
  has_many :game_activities, through: :games
  has_many :activities, through: :game_activities

  validates_presence_of :name, :email
  validates_uniqueness_of :email

  def wins
    games.where(win: true).count
  end

  def losses
    games.where(win: false).count
  end

  def game_count
    games.count
  end

  def activity_count
    game_activities.joins(:activity).where(game_activities: { completed: true }).count
  end

  def update_or_create_streak
    if streaks.where(active: true).empty?
      Streak.create!(user_id: id)
    else
      streak = streaks.where(active: true).first
      streak.increase_by_one
    end
  end
end

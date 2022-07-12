class User < ApplicationRecord
  has_many :games, dependent: :destroy
  has_many :game_activities, through: :games
  has_many :activities, through: :game_activities

  validates_presence_of :name, :email
  validates_uniqueness_of :email

  def win_percentage
    (games.where(win: true).count.to_f / games.count).round(2)
  end
end

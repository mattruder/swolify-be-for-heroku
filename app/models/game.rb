class Game < ApplicationRecord
  belongs_to :user
  has_many :game_activities
  has_many :activities, through: :game_activities
end

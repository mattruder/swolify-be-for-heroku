class GameActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :game

  has_one :user, through: :game
end

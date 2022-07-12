class Game < ApplicationRecord
  belongs_to :user
  has_many :game_activities
  has_many :activities, through: :game_activities

  validates_presence_of :level
  enum level: ["easy", "hard"]

  def add_activities(categories)
    require "pry"; binding.pry
  end
end

class Activity < ApplicationRecord
  has_many :game_activities
  has_many :games, through: :game_activities

  validates_presence_of :name, :duration, :video, :description

  enum category: ["upper body", "lower body", "core", "cardio"]
end

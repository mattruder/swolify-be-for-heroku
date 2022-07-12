class Game < ApplicationRecord
  belongs_to :user
  has_many :game_activities, dependent: :destroy
  has_many :activities, through: :game_activities

  validates_presence_of :level
  enum level: ["easy", "hard"]

  def complete_game_activities(activity_names)
    GameActivity.complete_by_ids(completed_game_activities(activity_names))
  end

  def completed_activities(activity_names)
    activity_names.map do |activity|
      activities.where(name: activity)
    end
  end

  def completed_game_activities(activity_names)
    completed_activities(activity_names).map do |activity|
      GameActivity.find_by(activity_id: activity.ids.first).id
    end
  end
end

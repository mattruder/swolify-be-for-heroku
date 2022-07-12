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
  
  def add_activities(categories)
    turns = activity_num.divmod(categories.count)
    turns[0].times do
      categories.each { |cat| unique_activity(cat) }
    end
    if turns[1] > 0
      turns[1].times {unique_activity(categories)}
    end
  end

  def unique_activity(category)
    activity = Activity.where(category: category).sample
    if activities.include?(activity)
      unique_activity(category)
    else
      activities << activity
    end
  end

  def activity_num
    if self.easy?
      9
    elsif self.hard?
      16
    end
  end
end

class Game < ApplicationRecord
  belongs_to :user
  has_many :game_activities, dependent: :destroy
  has_many :activities, through: :game_activities

  validates_presence_of :level
  enum level: ["easy", "hard"]

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

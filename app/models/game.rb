class Game < ApplicationRecord
  belongs_to :user
  has_many :game_activities, dependent: :destroy
  has_many :activities, through: :game_activities
  after_create :add_free_activity
  after_update :user_streak_update

  validates_presence_of :level
  enum level: ["easy", "hard"]

  def add_free_activity
    activities << Activity.where(category: "free").first
  end

  def completed_activities
    activities = game_activities.where(completed: true)
    activities.map {|act| act.activity}
  end

  def categories_present?(categories)
    if valid_categories(categories).any?
      return true
    else
      errors.add(:categories, "Must have at least one valid category")
      return false
    end
  end

  def valid_categories(categories)
    valid = ["cardio", "core", "upper body", "lower body"]
    categories.select {|cat| valid.include?(cat)}
  end

  def add_activities(categories)
    categories_to_add = valid_categories(categories)
    turns = activity_num.divmod(categories_to_add.count)
    turns[0].times do
      categories_to_add.each { |cat| unique_activity(cat) }
    end
    if turns[1] > 0
      turns[1].times {unique_activity(categories_to_add)}
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
      8
    elsif self.hard?
      15
    end
  end

  def user_streak_update
    if win == true
      user.update_or_create_streak
    end
  end
end

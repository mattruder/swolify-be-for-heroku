class Game < ApplicationRecord
  belongs_to :user
  has_many :game_activities, dependent: :destroy
  has_many :activities, through: :game_activities
  after_create :add_free_activity

  validates_presence_of :level
  enum level: ["easy", "hard"]

  def add_free_activity
    activities << Activity.where(category: "free").first
  end

  # def complete_game_activities(activity_names)
  #   require "pry"; binding.pry
  #   GameActivity.complete_by_ids(completed_game_activities(activity_names))
  #   # require "pry"; binding.pry
  # end

  # def completed_game_activities(activity_names)
  #   acts = game_activities.joins(:activity).where(activities: {name: activity_names})
  #   acts.map {|a| a.id }
  #   # require "pry"; binding.pry
  # end

  def game_completed_activities
    # activities.joins(:game_activities).where(game_activities: {completed: true, game: self})
    activities = game_activities.where(completed: true)
    activities.map {|act| act.activity}
  end

  # def completed_activities(activity_names)
  #   require "pry"; binding.pry
  #   activity_names.map do |activity|
  #     activities.where(name: activity)
  #   end
  # end
  # #
  # def completed_game_activities(activity_names)
  #   require "pry"; binding.pry
  #   completed_activities(activity_names).map do |activity|
  #     GameActivity.find_by(activity_id: activity.ids.first).id
  #   end
  # end

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
end

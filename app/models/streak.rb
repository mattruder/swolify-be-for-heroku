class Streak < ApplicationRecord
  belongs_to :user

  validates :active, inclusion: [true, false]
  validates_presence_of :days_in_a_row

  def increase_by_one
    if not_updated_yet_today
      new_count = self.days_in_a_row + 1
      self.update(days_in_a_row: new_count)
    end
  end

  def not_updated_yet_today
    self.updated_at.to_date != Date.today
  end
end

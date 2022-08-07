class Streak < ApplicationRecord
  belongs_to :user

  validates :active, inclusion: [true, false]
  validates_presence_of :days_in_a_row
end

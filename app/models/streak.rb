class Streak < ApplicationRecord
  belongs_to :user

  validates_presence_of :active, :days_in_a_row
end

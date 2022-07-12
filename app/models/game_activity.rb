class GameActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :game

  has_one :user, through: :game

  def self.complete_by_ids(ids)
    ids.each { |id| find(id).update(completed: true) }
  end
end

class GameActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :game

  has_one :user, through: :game

  def self.complete(ids)
    where(id: ids).update(completed: true)
    # ids.each { |id| find(id).update(completed: true) }
  end
end

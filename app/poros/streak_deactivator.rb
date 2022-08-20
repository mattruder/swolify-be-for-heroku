class StreakDeactivator

  def self.inactivate_old_streaks
    old_streaks.update_all(active: false)
  end


  def self.old_streaks
    Streak.where(active: true).where("updated_at < ?", 1.day.ago)
  end

end

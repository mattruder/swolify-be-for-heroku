desc "Heroku scheduler for updating Streaks"

task :inactivate_old_streaks => :environment do
  streaks = Streak.where(active: true).where.not(updated_at: Date.yesterday)
  count = streaks.count
  streaks.update_all(active: false)
  puts "#{count} streaks have been deactivated"
end

desc "Heroku scheduler for updating Streaks"

task :inactivate_old_streaks => :environment do
  streaks = Streak.where(active: true).where.not(updated_at: Date.yesterday)
  streaks.update_all(active: false)
  puts "#{streaks.count} streaks have been deactivated"
end

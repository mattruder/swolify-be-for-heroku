desc "Heroku scheduler for updating Streaks"

task :inactivate_old_streaks => :environment do
  count = StreakDeactivator.old_streaks.count
  StreakDeactivator.inactivate_old_streaks
  puts "#{count} streaks have been deactivated"
end

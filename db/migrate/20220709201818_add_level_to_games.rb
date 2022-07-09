class AddLevelToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :level, :integer
  end
end

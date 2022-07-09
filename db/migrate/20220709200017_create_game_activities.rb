class CreateGameActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :game_activities do |t|
      t.references :activity, foreign_key: true
      t.references :game, foreign_key: true
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end

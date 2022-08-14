class CreateStreaks < ActiveRecord::Migration[5.2]
  def change
    create_table :streaks do |t|
      t.references :user, foreign_key: true
      t.boolean :active, default: true
      t.integer :days_in_a_row, default: 1

      t.timestamps
    end
  end
end

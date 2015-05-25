class CreateUserOnlineEvents < ActiveRecord::Migration
  def change
    create_table :user_online_events do |t|
      t.integer :user_id
      t.integer :hours_played
      t.integer :place_taken
      t.integer :online_site_id
      t.float :prize
      t.text :comment

      t.timestamps
    end
  end
end

class CreateUserCasinoEvents < ActiveRecord::Migration
  def change
    create_table :user_casino_events do |t|
      t.integer :user_id
      t.integer :casino_id
      t.integer :hours_played
      t.integer :place_taken
      t.float :prize
      t.text :comment


      t.timestamps
    end
  end
end

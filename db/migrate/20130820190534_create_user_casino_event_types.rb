class CreateUserCasinoEventTypes < ActiveRecord::Migration
  def change
    create_table :user_casino_event_types do |t|
      t.integer :user_online_event_id
      t.string :name

      t.timestamps
    end

    add_index :user_casino_event_types, :user_online_event_id
  end
end

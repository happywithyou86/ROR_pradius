class CreateSuspendedUsers < ActiveRecord::Migration
  def change
    create_table :suspended_users do |t|
      t.integer :user_id

      t.timestamps
    end

    add_index :suspended_users, :user_id
  end
end

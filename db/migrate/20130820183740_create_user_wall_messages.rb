class CreateUserWallMessages < ActiveRecord::Migration
  def change
    create_table :user_wall_messages do |t|
      t.integer :user_id
      t.text :message
      t.integer :from_user_id

      t.timestamps
    end
  end
end

class CreateUserNicknames < ActiveRecord::Migration
  def change
    create_table :user_nicknames do |t|
      t.integer :user_id
      t.string :name
      t.string :location_type
      t.integer :location_id

      t.timestamps
    end
  end
end

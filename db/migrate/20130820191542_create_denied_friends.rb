class CreateDeniedFriends < ActiveRecord::Migration
  def change
    create_table :denied_friends do |t|
      t.integer :requestee_id
      t.integer :requester_id

      t.timestamps
    end

    add_index :denied_friends, [:requestee_id, :requester_id]
  end
end

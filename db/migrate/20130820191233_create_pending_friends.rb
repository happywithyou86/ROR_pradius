class CreatePendingFriends < ActiveRecord::Migration
  def change
    create_table :pending_friends do |t|
      t.integer :requester_id
      t.integer :requestee_id
      t.string  :how_you_know_him
      t.text    :message


      t.timestamps
    end

    add_index :pending_friends, [:requestee_id, :requester_id]
  end
end

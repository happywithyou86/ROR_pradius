class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.string :poker_room_type
      t.integer :poker_room_id
      t.integer :user_id
      t.integer :rating

      t.timestamps
    end
  end
end

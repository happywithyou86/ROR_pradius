
class AddPokerRoomToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :poker_room_id, :integer
    add_column :experiences, :poker_room_type, :string

    add_index :experiences, [:poker_room_type, :poker_room_id]
  end
end

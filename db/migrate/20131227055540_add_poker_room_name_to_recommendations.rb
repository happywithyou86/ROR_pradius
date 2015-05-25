class AddPokerRoomNameToRecommendations < ActiveRecord::Migration
  def change
    add_column :recommendations, :room_name, :string
  end
end

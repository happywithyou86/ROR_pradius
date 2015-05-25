class AddFieldToOnlineHighlightAndCasinoHighLight < ActiveRecord::Migration
  def change
  	add_column :online_highlights, :most_profitable_24_hours_room, :string
    add_column :online_highlights, :largest_loss_in_24_hours, :string
    add_column :casino_highlights, :most_profitable_24_hours_room, :string
    add_column :casino_highlights, :largest_loss_in_24_hours, :string
  end
end

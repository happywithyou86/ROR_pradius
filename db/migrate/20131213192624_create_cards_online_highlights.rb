class CreateCardsOnlineHighlights < ActiveRecord::Migration
  def change
    create_table :cards_online_highlights do |t|
      t.belongs_to :card
      t.belongs_to :online_highlight
    end
  end
end

class CreateCardsCasinoHighlights < ActiveRecord::Migration
  def change
    create_table :cards_casino_highlights do |t|
      t.belongs_to :card
      t.belongs_to :casino_highlight
    end
  end
end

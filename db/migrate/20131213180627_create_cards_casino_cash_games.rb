class CreateCardsCasinoCashGames < ActiveRecord::Migration
  def change
    create_table :cards_casino_cash_games do |t|
      t.belongs_to :card
      t.belongs_to :casino_cash_game
    end
  end
end

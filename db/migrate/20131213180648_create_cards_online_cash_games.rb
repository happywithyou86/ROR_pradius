class CreateCardsOnlineCashGames < ActiveRecord::Migration
  def change
    create_table :cards_online_cash_games do |t|
      t.belongs_to :card
      t.belongs_to :online_cash_game
    end
  end
end

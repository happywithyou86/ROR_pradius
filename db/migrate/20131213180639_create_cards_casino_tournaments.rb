class CreateCardsCasinoTournaments < ActiveRecord::Migration
  def change
    create_table :cards_casino_tournaments do |t|
      t.belongs_to :card
      t.belongs_to :casino_tournament
    end
  end
end

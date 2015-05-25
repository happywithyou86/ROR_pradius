class CreateCardsOnlineTournaments < ActiveRecord::Migration
  def change
    create_table :cards_online_tournaments do |t|
      t.belongs_to :card
      t.belongs_to :online_tournament
    end
  end
end

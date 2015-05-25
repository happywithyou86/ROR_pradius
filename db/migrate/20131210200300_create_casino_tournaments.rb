class CreateCasinoTournaments < ActiveRecord::Migration
  def change
    create_table :casino_tournaments do |t|
      t.belongs_to :user
      t.integer :buy_in
      t.integer :players
      t.string :win_loss
      t.string :location
      t.string :title
      t.string :rank
      t.string :best_hand
      t.string :duration
      t.string :note
      t.string :cash_tourn_type, default: 'Tournament'
      t.integer :hours
      t.integer :minutes

      t.timestamps
    end
  end
end

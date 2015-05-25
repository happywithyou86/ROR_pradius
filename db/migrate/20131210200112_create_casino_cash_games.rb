class CreateCasinoCashGames < ActiveRecord::Migration
  def change
    create_table :casino_cash_games do |t|
      t.belongs_to :user
      t.string :win_loss
      t.string :location
      t.string :stake
      t.string :duration
      t.string :best_hand
      t.string :note
      t.string :cash_tourn_type, default: 'Cash'
      t.integer :hours
      t.integer :minutes

      t.timestamps
    end
  end
end

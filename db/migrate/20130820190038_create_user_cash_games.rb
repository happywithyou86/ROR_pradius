class CreateUserCashGames < ActiveRecord::Migration
  def change
    create_table :user_cash_games do |t|
      t.integer :user_id
      t.string :name
      t.string :stake
      t.integer :duration
      t.string :best_hand
      t.boolean :win_loss
      t.string :location_type
      t.integer :location_id


      t.timestamps
    end
  end
end

class CreateUserCashGameTypes < ActiveRecord::Migration
  def change
    create_table :user_cash_game_types do |t|
      t.integer :user_cash_game_id
      t.string :name

      t.timestamps
    end

    add_index :user_cash_game_types, :user_cash_game_id
  end
end

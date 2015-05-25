class CreateUserCashGameNotes < ActiveRecord::Migration
  def change
    create_table :user_cash_game_notes do |t|
      t.integer :user_cash_game_id
      t.string :note

      t.timestamps
    end

    add_index :user_cash_game_notes, :user_cash_game_id
  end
end

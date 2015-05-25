class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :prid
      t.string :email
      t.string :password_digest
      t.string :name
      t.boolean :online_player, default: false
      t.boolean :casino_player, default: false
      t.date :year_started_playing_poker
      t.string :confirmation_code
      t.boolean :confirmed_account, default: false
      t.string :quote, default: "--"


      t.timestamps
    end

    add_index :users, :email
    add_index :users, :prid
  end
end

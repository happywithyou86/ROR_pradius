class CreateFavoriteCasinos < ActiveRecord::Migration
  def change
    create_table :favorite_casinos do |t|
      t.integer :user_id
      t.integer :casino_id

      t.timestamps
    end

    add_index :favorite_casinos, :user_id
  end
end

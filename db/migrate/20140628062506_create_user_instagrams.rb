class CreateUserInstagrams < ActiveRecord::Migration
  def change
    create_table :user_instagrams do |t|
      t.integer :user_id
      t.string :url
      
      t.timestamps
    end
    add_index :user_instagrams, :user_id
  end
end

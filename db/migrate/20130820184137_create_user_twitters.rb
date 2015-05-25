class CreateUserTwitters < ActiveRecord::Migration
  def change
    create_table :user_twitters do |t|
      t.integer :user_id
      t.string :url

      t.timestamps
    end

    add_index :user_twitters, :user_id
  end
end

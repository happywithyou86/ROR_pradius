class CreateUserLocations < ActiveRecord::Migration
  def change
    create_table :user_locations do |t|
      t.integer :user_id
      t.string :location, default: ""
      t.integer :country_id, default: 1
      t.string :postal_code
      t.float :latitude
      t.float :longitude
      t.boolean :hide_city, default: false

      t.timestamps
    end

    add_index :user_locations, :user_id
  end
end

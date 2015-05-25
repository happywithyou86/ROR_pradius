class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :url
      t.integer :country_id
      t.integer :position

      t.timestamps
    end
  end
end

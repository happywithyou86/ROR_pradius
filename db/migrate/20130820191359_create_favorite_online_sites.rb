class CreateFavoriteOnlineSites < ActiveRecord::Migration
  def change
    create_table :favorite_online_sites do |t|
      t.integer :user_id
      t.integer :online_site_id

      t.timestamps
    end

    add_index :favorite_online_sites, :user_id
  end
end

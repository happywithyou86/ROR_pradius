class CreateUserProfilePictures < ActiveRecord::Migration
  def change
    create_table :user_profile_pictures do |t|
      t.integer :user_id
      t.string :url

      t.timestamps
    end

    add_index :user_profile_pictures, :user_id
  end
end

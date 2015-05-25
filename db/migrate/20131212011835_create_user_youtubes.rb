class CreateUserYoutubes < ActiveRecord::Migration
  def change
    create_table :user_youtubes do |t|
      t.integer :user_id
      t.string :url

      t.timestamps
    end

    add_index :user_youtubes, :user_id
  end
end

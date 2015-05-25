class CreateUserBlogs < ActiveRecord::Migration
  def change
    create_table :user_blogs do |t|
      t.integer :user_id
      t.string :url

      t.timestamps
    end

    add_index :user_blogs, :user_id
  end
end

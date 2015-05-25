class CreateActivityLikes < ActiveRecord::Migration
  def change
    create_table :activity_likes do |t|
      t.integer :user_id
      t.integer :klass_id
      t.string :klass_name

      t.timestamps
    end
  end
end

class CreateForumThreads < ActiveRecord::Migration
  def change
    create_table :forum_threads do |t|
      t.string :name
      t.integer :user_id
      t.integer :forum_section_id
      t.integer :views, default: 0

      t.timestamps
    end
  end
end

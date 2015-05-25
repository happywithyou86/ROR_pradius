class CreateForumSections < ActiveRecord::Migration
  def change
    create_table :forum_sections do |t|
      t.string :name
      t.integer :forum_id
      t.text :description

      t.timestamps
    end
  end
end

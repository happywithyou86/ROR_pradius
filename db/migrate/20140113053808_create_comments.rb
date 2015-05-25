class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commentable_id
      t.string :commentable_type
      t.belongs_to :user
      t.string :text


      t.timestamps
    end
  end
end

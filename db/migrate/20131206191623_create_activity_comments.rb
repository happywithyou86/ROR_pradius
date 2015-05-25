class CreateActivityComments < ActiveRecord::Migration
  def change
    create_table :activity_comments do |t|
      t.integer :user_id
      t.string :klass_name
      t.integer :klass_id
      t.text   :comment

      t.timestamps
    end
  end
end

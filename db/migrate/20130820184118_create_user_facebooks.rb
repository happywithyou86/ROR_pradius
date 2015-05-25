class CreateUserFacebooks < ActiveRecord::Migration
  def change
    create_table :user_facebooks do |t|
      t.integer :user_id
      t.string :url

      t.timestamps
    end

    add_index :user_facebooks, :user_id
  end
end

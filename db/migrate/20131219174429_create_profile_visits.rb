class CreateProfileVisits < ActiveRecord::Migration
  def change
    create_table :profile_visits do |t|
      t.integer :profile_user_id
      t.integer :visitor_id

      t.timestamps
    end

    add_index :profile_visits, [:profile_user_id, :visitor_id]
  end
end

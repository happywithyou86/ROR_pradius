class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.belongs_to :user
      t.string :description
      t.string :online_casino

      t.timestamps
    end
  end
end

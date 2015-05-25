class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.belongs_to :user
      t.string :position
      t.string :location
      t.string :city
      t.string :state
      t.string :online_casino
      t.string :nickname
      t.string :description
      t.boolean :present
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end

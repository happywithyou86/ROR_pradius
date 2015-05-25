class CreateOnlineSites < ActiveRecord::Migration
  def change
    create_table :online_sites do |t|
      t.string :name
      t.text :url

      t.timestamps
    end
  end
end

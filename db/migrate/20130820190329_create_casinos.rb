class CreateCasinos < ActiveRecord::Migration
  def change
    create_table :casinos do |t|
      t.string :name
      t.text :url

      t.timestamps
    end

   # add_index :casinos, :url
  end
end

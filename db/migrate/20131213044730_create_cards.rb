class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :value
      t.string :number
      t.string :suit

      t.timestamps
    end
  end
end

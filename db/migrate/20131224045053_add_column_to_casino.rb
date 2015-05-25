class AddColumnToCasino < ActiveRecord::Migration
  def change
    add_column :casinos, :downcased_name, :string
  end
end

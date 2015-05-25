class AddColumnToOnlineSite < ActiveRecord::Migration
  def change
    add_column :online_sites, :downcased_name, :string
  end
end

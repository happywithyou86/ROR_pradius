class AddSignInCountToUser < ActiveRecord::Migration
  def change
  	add_column :users, :sign_in_count, :integer, :limit => 8, :default => 0
  end
end

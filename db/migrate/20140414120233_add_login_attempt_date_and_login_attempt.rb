class AddLoginAttemptDateAndLoginAttempt < ActiveRecord::Migration
  def change
  	add_column :users, :login_attempt_date, :date
  	add_column :users, :login_attempt, :integer,:default => 0, :null => false
  end
end

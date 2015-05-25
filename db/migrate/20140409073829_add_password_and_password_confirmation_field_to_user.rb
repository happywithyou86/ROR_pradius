class AddPasswordAndPasswordConfirmationFieldToUser < ActiveRecord::Migration
  def change
  	add_column :users, :password, :string, :after => :email
  	add_column :users, :password_confirmation, :string, :after => :password
  end
end

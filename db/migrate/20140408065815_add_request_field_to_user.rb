class AddRequestFieldToUser < ActiveRecord::Migration
  def change
  	 add_column :users, :request_confirm_code, :integer
  end
end

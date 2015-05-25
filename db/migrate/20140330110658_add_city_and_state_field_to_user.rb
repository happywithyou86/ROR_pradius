class AddCityAndStateFieldToUser < ActiveRecord::Migration
  def change
  	add_column :user_locations, :state_and_city, :string
  end
end

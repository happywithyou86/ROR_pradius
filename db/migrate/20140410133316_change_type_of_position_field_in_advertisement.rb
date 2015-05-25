class ChangeTypeOfPositionFieldInAdvertisement < ActiveRecord::Migration
  def change
  	change_column :advertisements, :position, :string
  end
end

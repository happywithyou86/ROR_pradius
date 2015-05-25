class AddImageToAdvertisement < ActiveRecord::Migration
  def change
  	add_attachment :advertisements, :image  

  end
end

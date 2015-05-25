class ChangeTypeOfYouTubeUrl < ActiveRecord::Migration
  def change
  	change_column :user_youtubes, :url, :text
  end
end

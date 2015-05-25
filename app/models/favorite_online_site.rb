# == Schema Information
#
# Table name: favorite_online_sites
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  online_site_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class FavoriteOnlineSite < ActiveRecord::Base
  belongs_to :user

  belongs_to :online_site
  validates_presence_of :online_site_id, :message => "Favorite Online Casino Room selection required"

  #validates :online_site_id, :presence => {:message => 'Favorite Online Casino Room selection required.'}

end

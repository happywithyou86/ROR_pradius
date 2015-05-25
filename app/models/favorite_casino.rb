# == Schema Information
#
# Table name: favorite_casinos
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  casino_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class FavoriteCasino < ActiveRecord::Base
	#
  belongs_to :user

  belongs_to :casino
  validates_presence_of :casino_id, :message => "Favorite Online Casino Room selection required"
 # validates :casino_id, :presence => {:message => 'Favorite Casino Online Room selection required.'}


end

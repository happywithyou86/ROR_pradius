# == Schema Information
#
# Table name: user_tournament_notes
#
#  id                 :integer          not null, primary key
#  user_tournament_id :integer
#  note               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class UserTournamentNote < ActiveRecord::Base
  has_one :user_tournament

end

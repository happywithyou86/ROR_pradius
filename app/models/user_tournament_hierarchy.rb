# == Schema Information
#
# Table name: user_tournament_hierarchies
#
#  id                 :integer          not null, primary key
#  user_tournament_id :integer
#  top_paid           :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class UserTournamentHierarchy < ActiveRecord::Base
  has_one :user_tournament

end

# == Schema Information
#
# Table name: user_tournament_capacities
#
#  id                 :integer          not null, primary key
#  user_tournament_id :integer
#  total              :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class UserTournamentCapacity < ActiveRecord::Base
  has_one :user_tournament
end

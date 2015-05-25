# == Schema Information
#
# Table name: user_tournaments
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  title         :string(255)
#  buy_in        :float
#  duration      :integer
#  final_rank    :integer
#  best_hand     :string(255)
#  win_loss      :boolean
#  prize         :float
#  type          :string(255)
#  location_type :string(255)
#  location_id   :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class UserTournament < ActiveRecord::Base
  belongs_to :user
  belongs_to :location, polymorphic: true

  has_one :user_tournament_hierarchy
  has_one :user_tournament_note
  has_one :user_tournament_capacity
end

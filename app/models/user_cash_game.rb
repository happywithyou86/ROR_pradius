# == Schema Information
#
# Table name: user_cash_games
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  name          :string(255)
#  stake         :string(255)
#  duration      :integer
#  best_hand     :string(255)
#  win_loss      :boolean
#  location_type :string(255)
#  location_id   :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class UserCashGame < ActiveRecord::Base
  belongs_to :user
  belongs_to :location, polymorphic: true

  has_one :user_cash_game_type
  has_one :user_cash_game_note


end

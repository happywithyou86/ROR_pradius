# == Schema Information
#
# Table name: user_cash_game_types
#
#  id                :integer          not null, primary key
#  user_cash_game_id :integer
#  name              :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class UserCashGameType < ActiveRecord::Base
  belongs_to :user_cash_game

end

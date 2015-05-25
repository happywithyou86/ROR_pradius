# == Schema Information
#
# Table name: user_cash_game_notes
#
#  id                :integer          not null, primary key
#  user_cash_game_id :integer
#  note              :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class UserCashGameNote < ActiveRecord::Base

  belongs_to :user_cash_game
end

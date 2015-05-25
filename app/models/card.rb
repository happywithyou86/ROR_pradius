# == Schema Information
#
# Table name: cards
#
#  id         :integer          not null, primary key
#  value      :string(255)
#  number     :string(255)
#  suit       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Card < ActiveRecord::Base
  has_and_belongs_to_many :online_tournaments
  has_and_belongs_to_many :online_cash_games
  has_and_belongs_to_many :casino_tournaments
  has_and_belongs_to_many :casino_cash_games
  has_and_belongs_to_many :online_highlights
  has_and_belongs_to_many :casino_highlights


end

# == Schema Information
#
# Table name: online_highlights
#
#  id                      :integer          not null, primary key
#  user_id                 :integer
#  total_profit_loss       :string(255)      default("0")
#  most_prof_room          :string(255)
#  least_prof_room         :string(255)
#  most_prof_24_date       :datetime
#  most_prof_24_amount     :string(255)      default("0")
#  largest_loss_24_date    :datetime
#  largest_loss_24_amount  :string(255)      default("(0)")
#  years_playing_start     :datetime
#  years_playing_end       :datetime
#  total_tournaments       :integer          default(0)
#  tourn_most_consec_hours :integer          default(0)
#  tourn_total_cashed      :integer          default(0)
#  tourn_total_not_cashed  :integer          default(0)
#  best_placement          :integer
#  best_placement_room     :string(255)
#  best_placement_name     :string(255)
#  best_placement_rank     :string(255)
#  most_exp_buy_in         :integer
#  most_exp_amount         :string(255)
#  most_exp_name           :string(255)
#  most_exp_location       :string(255)
#  cash_consec_hours       :integer          default(0)
#  cash_best_hand          :integer          default(0)
#  cash_worst_loss         :integer
#  cash_worst_loss_date    :datetime
#  cash_worst_loss_amount  :string(255)
#  cash_worst_loss_room    :string(255)
#  cash_largest_win        :integer
#  cash_largest_win_date   :datetime
#  cash_largest_win_amount :string(255)
#  cash_largest_win_room   :string(255)
#  cash_total_profit_days  :integer          default(0)
#  cash_total_loss_days    :integer          default(0)
#  created_at              :datetime
#  updated_at              :datetime
#

class OnlineHighlight < ActiveRecord::Base
  has_and_belongs_to_many :cards

  belongs_to :user

  belongs_to :tournament_best, :foreign_key => :best_placement, :class_name => 'OnlineTournament'
  belongs_to :tournament_most_exp, :foreign_key => :most_exp_buy_in, :class_name => 'OnlineTournament'

  belongs_to :cash_largest, :foreign_key => :cash_largest_win, :class_name => 'OnlineCashGame'
  belongs_to :cash_worst, :foreign_key => :cash_worst_loss, :class_name => 'OnlineCashGame'

end


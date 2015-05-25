# == Schema Information
#
# Table name: online_cash_games
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  win_loss        :string(255)
#  location        :string(255)
#  stake           :string(255)
#  duration        :string(255)
#  best_hand       :string(255)
#  note            :string(255)
#  cash_tourn_type :string(255)      default("Cash")
#  hours           :integer
#  minutes         :integer
#  created_at      :datetime
#  updated_at      :datetime
#


class OnlineCashGame < ActiveRecord::Base
  has_and_belongs_to_many :cards
  belongs_to :user

  #validates_presence_of :location

  before_save :convert_duration

  class << self
    def within_a_year_for_user user
      where("user_id = ? AND created_at >= ?", user.id, 1.year.ago)
    end

    def created_this_month user
      where("user_id = ? AND created_at >= ? AND created_at < ?", user.id, DateTime.now.beginning_of_month, DateTime.now.next_month.beginning_of_month)
    end
  end

  private
    def convert_duration
      dur = self.duration.split(':').map{|v| v.gsub(/\D/, '')}
      self.hours =  dur.first
      self.minutes = dur.last
    end
end

# == Schema Information
#
# Table name: recommendation_comments
#
#  id                :integer          not null, primary key
#  recommendation_id :integer
#  comment           :text
#  created_at        :datetime
#  updated_at        :datetime
#

class RecommendationComment < ActiveRecord::Base
  belongs_to :recommendation
end

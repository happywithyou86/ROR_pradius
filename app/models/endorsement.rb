# == Schema Information
#
# Table name: endorsements
#
#  id          :integer          not null, primary key
#  endorser_id :integer
#  endorsee_id :integer
#  message     :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Endorsement < ActiveRecord::Base
  belongs_to :endorser, class_name: "User", foreign_key: "endorser_id"
  belongs_to :endorsee, class_name: "User", foreign_key: "endorsee_id"

  validates_uniqueness_of :endorser_id, scope: :endorsee_id

  validates :message, presence: true
end

# == Schema Information
#
# Table name: forums
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Forum < ActiveRecord::Base
  has_many :forum_sections
end

# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_attached_file :image, 
      styles: { small: "64x64", med: "100x100", large: "266x350"},
      :storage => 's3',
      :s3_credentials => {
      :bucket => "AdvertismentImages",
      :access_key_id => "AKIAIL2JJRQ5QJEQFJZA",
      :secret_access_key => "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"
       }
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/pjpeg', 'image/tif', 'image/gif','image/tiff'], :message => "has to be in a proper format"
  belongs_to :user
  #validates_presence_of :status

  class << self
    def post_feed_for_user user, page
      ids = Friend.friend_ids_of_user(user) << user.id
      Post.includes(:likes).includes(:comments).where(:user_id => ids).paginate(:page => page, :per_page => 10).order('id DESC')
    end
  end

  def is_liked_by_user? user
    self.likes.map(&:user_id).include?(user.id)
  end
end

# == Schema Information
#
# Table name: users
#
#  id                         :integer          not null, primary key
#  prid                       :string(255)
#  email                      :string(255)
#  password_digest            :string(255)
#  name                       :string(255)
#  online_player              :boolean          default(FALSE)
#  casino_player              :boolean          default(FALSE)
#  year_started_playing_poker :date
#  confirmation_code          :string(255)
#  confirmed_account          :boolean          default(FALSE)
#  quote                      :string(255)      default("--")
#  created_at                 :datetime
#  updated_at                 :datetime
#

class User < ActiveRecord::Base
  has_secure_password
  include ApplicationHelper

  #include Mailboxer::Models::Messageable
  #has_one :reset_user_password, dependent: :destroy
 # attr_protected :password_digest
  has_one :user_blog, dependent: :destroy
  has_one :user_facebook, dependent: :destroy
  has_one :user_twitter, dependent: :destroy
  has_one :user_youtube, dependent: :destroy
  has_one :user_instagram, dependent: :destroy
  has_one :user_location, dependent: :destroy
  has_one :user_nickname, dependent: :destroy
  has_one :user_profile_picture, dependent: :destroy
  has_one :favorite_casino, dependent: :destroy
  has_one :favorite_online_site, dependent: :destroy
  has_one :suspended_user, dependent: :destroy
  has_one :user_subscription, dependent: :destroy

  has_one :online_highlight, dependent: :destroy
  has_one :casino_highlight, dependent: :destroy

  has_many :user_casino_events
  has_many :user_online_events
  has_many :user_cash_games
  has_many :user_nicknames
  has_many :user_tournaments
  has_many :recommendations
  has_many :activity_likes
  has_many :activity_comments
  has_many :experiences
  has_many :achievements
  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :comments

  has_many :has_user_wall_messages, foreign_key: "user_id", class_name: "UserWallMessage"
  has_many :published_wall_messages, foreign_key: "from_user_id", class_name: "UserWallMessage"
  has_many :has_friends, foreign_key: "user_id", class_name: "Friend"
  has_many :friends, foreign_key: "friend_id", class_name: "Friend"
  has_many :visited, foreign_key: "profile_user_id", class_name: "ProfileVisit"
  has_many :visitors, foreign_key: "visitor_id", class_name: "ProfileVisit"
  has_many :denied_friends, foreign_key: "requester_id", class_name: "DeniedFriend"
  has_many :has_denied_friends, foreign_key: "requestee_id", class_name: "DeniedFriend"
  has_many :has_pending_friends, foreign_key: "requester_id", class_name: "PendingFriend"
  has_many :pending_friends, foreign_key: "requestee_id", class_name: "PendingFriend"
  has_many :has_endorsed, foreign_key: "endorser_id", class_name: "Endorsement"
  has_many :endorsements, foreign_key: "endorsee_id", class_name: "Endorsement"
  has_many :forum_threads
  has_many :forum_posts

  has_many :online_tournaments, dependent: :destroy
  has_many :casino_tournaments, dependent: :destroy
  has_many :online_cash_games, dependent: :destroy
  has_many :casino_cash_games, dependent: :destroy

  validates_presence_of :name, :message => "Name fields can't be blank"
  validates_presence_of :email,  :message => "Email can't be blank"

  validates_presence_of :password,  :message => "Password can't be blank", on: :create
  validates_confirmation_of :password,  :message => "Password should match password confirmation", on: :create
  validates :password_digest, presence: true
  validates :prid, presence: true, uniqueness: true, on: :update
  validate :verify_prid, on: :create

  validates_uniqueness_of :name, :message => "Name already Taken"
  validates_uniqueness_of :email, :message => "Email already Taken"
  #validates_uniqueness_of :password, :message => "Password already Taken"
 # validates_uniqueness_of :custom_url, :message => "Url already Taken"

  accepts_nested_attributes_for :user_location, :favorite_casino, :favorite_online_site, :user_profile_picture,:user_blog
  acts_as_messageable

  before_create :create_confirmation_code
  after_create :email_user_confirm_code
  after_create :create_user_location
  after_create :create_user_highlights
  after_save :choose_plan_type
  acts_as_mappable

  def choose_plan_type
   Stripe.api_key = stripe_keys("api_key")
   begin
   if  (self.plan_type =="premium_plan_monthly" || self.plan_type =="premium_plan_annual" ||  self.plan_type == "basic") && (!self.user_subscription.blank? ) 
     if !self.user_subscription.stripe_customer_token.nil?
      customer = Stripe::Customer.retrieve(self.user_subscription.stripe_customer_token)   
      if (self.plan_type =="premium_plan_monthly")
      customer.update_subscription(:plan => 101, :prorate => true)

      elsif  (self.plan_type =="premium_plan_annual")
      customer.update_subscription(:plan => 100, :prorate => true)

      elsif  (self.plan_type =="basic")
        unless customer.nil? 
        subscription = customer.subscriptions.data[0]
          if !subscription.nil? && subscription.status == 'active'
            customer.cancel_subscription
         end
        end
     end 
    end
   end
   rescue Stripe::InvalidRequestError => e
        logger.error "Stripe error while creating customer: #{e.message}"
        errors.add :base, "There was a problem with your coupon."
        false
        rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
          errors.add :base, "There was a problem with your credit card.#{e.message}#{customer}"
          false
    
     rescue Stripe::AuthenticationError => e
      logger.error "Stripe error while creating customer: #{e.message}"
          errors.add :base, "There was a problem with your credit card.#{e.message}#{customer}"
          false
      end
  end
  def verify_prid
    if User.first
      self.prid = (User.last.prid.to_i + 1).to_s
    else
      self.custom_url = "1"
      self.prid = "1"
    end
      self.custom_url =self.prid
  end



  # Scoped queries
  def self.friends_of_user user
    friend_objs = Friend.friend_ids_of_user(user)
    User.where(:id => friend_objs)
  end


  def is_friends_with? user
    Friend.friend_ids_of_user(self).include?(user.id)
  end


  def email_user_confirm_code
   # UserMailer.confirm_account(self)
     UserMailer.confirm_first_account(self)
  end

  def create_confirmation_code
    self.confirmation_code = SecureRandom.urlsafe_base64
  end

  def create_user_location
    if self.user_location.blank?
      UserLocation.create(user_id: self.id)
    end
  end

  # This is used to find or create the associated model
  def find_or_create(model)
    if self.send(model).nil?
      model.to_s.split("_").map {|word| word.capitalize}.join.constantize.send(:new, {user_id: self.id})
    else
      self.send(model)
    end
  end

  def format_for_edit
    self.build_user_location if self.user_location.blank?
    self.build_user_facebook if self.user_facebook.blank?
    self.build_user_twitter if self.user_twitter.blank?
    self.build_user_blog if self.user_blog.blank?
    self.build_favorite_casino if self.favorite_casino.blank?
    self.build_favorite_online_site if self.favorite_online_site.blank?
    self.build_user_profile_picture if self.user_profile_picture.blank?

    return self
  end

  # For Mailboxer
  def mailboxer_name
    return self.prid
  end

  def mailboxer_email(object)
    return self.email
  end

  # Messaging and notifying
  # def send_message_and_notify receiver, body, convo=nil
  #   convo ||= self.mailbox.conversations.select { |c| c.participants.include?(receiver)}.first
  #   if !convo.nil?
  #       self.reply_to_conversation(convo, body)
  #   else
  #       self.send_message(receiver, body, 'Subject')
  #   end
  #   receiver.notify('new_message', 'message')
  #   self.mailbox.conversations.select { |c| c.participants.include?(receiver)}.first
  # end

  def unread_notifications_for type
  #  self.mailbox.notifications.unread.select {|n| n.subject == type}
  end

  # Create highlights

  def create_user_highlights
    OnlineHighlight.create(user_id: self.id)
    CasinoHighlight.create(user_id: self.id)
  end

  def self.custom_url_or_prid(prid)
    user =User.find_by_prid(prid)
      if user.nil?
        user =User.find_by_custom_url(prid)
      end
    return user
  end
end

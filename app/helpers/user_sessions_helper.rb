module UserSessionsHelper
  def sign_in_user(user)
    reset_session

    session[:id] = user.id

    self.current_user = user
  end

  def redirect_non_signed_in_user
    redirect_to root_url, notice: "Sorry, you aren't signed in." unless signed_in_user?
  end

  def redirect_signed_in_user
    redirect_to root_url, notice: "You're already signed in." if signed_in_user?
  end

  def signed_in_user?
    !current_user.nil?
  end

  def redirect_non_premium_user
    if signed_in_user?
      if current_user.plan_type != "free_access"
        verifyUserSubscription(self.current_user) #will delete subscriptions if not active
        if current_user.user_subscription.blank?
          redirect_to no_subscription_path
        end
      end
    end
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.includes([:favorite_casino => :casino]).includes([:favorite_online_site => :online_site]).find_by_id(session[:id])
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out_user
    self.current_user = nil
    reset_session
  end

  private
  def verifyUserSubscription(user)
    if user.user_subscription != nil
      customer_id = user.user_subscription.stripe_customer_token

      #Check all subscriptions (Note stripe limits to ten)
      active = false #default
      for subscription in Stripe::Customer.retrieve(customer_id)['subscriptions']
        if subscription["status"] == "active"
          active = true
        end
      end
      if active == false
        user.user_subscription = nil #Deletes Users Subscription
      end
    end
  end
end

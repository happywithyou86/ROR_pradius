class UserPlansController < ApplicationController
  before_action :redirect_non_signed_in_user
  include UserPlansHelper

  def new
    @user_subscription = UserSubscription.new
    @data = UserProfile.get(current_user.prid, current_user)
  end

  def edit
        @data = UserProfile.get(current_user.prid, current_user)

  end


  def no_subscription
    @data = UserProfile.get(current_user.prid, current_user)
  end

  def upgrade
      @title = "Upgrade Plan - Online Poker Network - Poker Radius Community"
    @data = UserProfile.get(current_user.prid, current_user)
  end

  def create

    @data = UserProfile.get(current_user.prid, current_user)
    @user_subscription = UserSubscription.new(user_subscription_params)
    @user_subscription.save_with_payment(current_user.email, params[:plan], params[:promotional_code], params[:user_subscription][:stripe_card_token])
    
    if !@user_subscription.blank?
      if !@user_subscription.stripe_customer_token.nil?
       UserPlanMailer.welcome(current_user)
       if params[:plan] == "Annually"
         current_user.plan_type = "premium_plan_annual"
          current_user.save
        elsif params[:plan] == "Monthly"
         current_user.plan_type = "premium_plan_monthly"
         current_user.save
        end
              redirect_to user_plans_subscribed_path( plan: params[:plan])

      else
         @user_subscription.destroy
         flash[:error]= "Your credit card was declined.  Please try again"
         redirect_to :back
      end

    end
  end

  def update
    if params[:card_token] != ""
      current_user.user_subscription.update_billing_information(params[:card_token])

      redirect_to "/users/#{current_user.prid}", :notice => "Updated Billing Information!"
    end
  end

  def history
        @data = UserProfile.get(current_user.prid, current_user)

    if !current_user.user_subscription.nil?
     @charge = current_user.user_subscription.get_payment_history()
   end
  end

  def subscribed
    @data = UserProfile.get(current_user.prid, current_user)

    @email = current_user.email
    if params[:plan] = "Monthly"
      @plan = "Premium Monthly Plan"
    else
      @plan = "Premium Annual Plan"
    end

    @user_id = current_user.prid
  end
  
  private

  def user_subscription_params
    params[:user_subscription][:user_id] = current_user.id

    params.require(:user_subscription).permit(:user_id, :stripe_card_token)
  end
end

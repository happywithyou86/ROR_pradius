class WebhookController < ApplicationController
  require 'json'
  def receiver
    Stripe.api_key = stripe_keys("api_key")
    data_json = JSON.parse request.body.read
     puts "#{data_json['data']['object']['customer']}"
    if data_json[:type] == "invoice.payment_failed"
     @user_plan =   UserSubscription.find_by_stripe_customer_token(data_json['data']['object']['customer'])
     @user_plan.user.plan_type = "basic"
     @user_plan.user.save
      customer = Stripe::Customer.retrieve(@user_plan.stripe_customer_token) 
     customer.cancel_subscription
    UserPlanMailer.decline_payment_mail(@user_plan.user)
    
    end
  end
end

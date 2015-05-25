# == Schema Information
#
# Table name: user_subscriptions
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  stripe_customer_token :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#

class UserSubscription < ActiveRecord::Base
  attr_accessor :stripe_card_token
  include ApplicationHelper

  belongs_to :user

  def save_with_payment(email, plan, promotional_code, stripe_card_token)
     begin 
      Stripe.api_key = stripe_keys("api_key")
        if promotional_code == ""
          stripe_create_cusomer(email, plan, nil, stripe_card_token)
        elsif promotional_code != ""
            coupon = Stripe::Coupon.retrieve(promotional_code)
            stripe_create_cusomer(email, plan, coupon, stripe_card_token)
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
        rescue Stripe::ApiConnectionError => e
          logger.error "Stripe error while creating customer: #{e.message}"
          errors.add :base, "There was a problem with your credit card.#{e.message}#{customer}"
          false
       rescue Stripe::Error => e
          logger.error "Stripe error while creating customer: #{e.message}"
          errors.add :base, "There was a problem with your credit card.#{e.message}#{customer}"
          false
      end
  end

  def update_billing_information(card_token)
    Stripe.api_key = stripe_keys("api_key")
    customer = Stripe::Customer.retrieve(self.stripe_customer_token)
    customer.card = card_token

    customer.save
  end

  def get_payment_history()
    Stripe.api_key = stripe_keys("api_key")
    return Stripe::Charge.all(:customer => self.stripe_customer_token, :count => 100)
  end

  private
  def stripe_create_cusomer(email, plan, coupon, stripe_card_token)
    begin
      Stripe.api_key = stripe_keys("api_key")
      if valid?
        if plan == "Monthly"
          if coupon != nil
            customer = Stripe::Customer.create(description: self.user_id, plan: "101", card: stripe_card_token, coupon: coupon, email: email)
          else
            customer = Stripe::Customer.create(description: self.user_id, plan: "101", card: stripe_card_token, email: email)
          end
        elsif plan == "Annually"
          if coupon != nil
            customer = Stripe::Customer.create(description: self.user_id, plan: "100", card: stripe_card_token, coupon: coupon, email: email)
          else
           customer = Stripe::Customer.create(description: self.user_id, plan: "100", card: stripe_card_token, email: email)
          end
        else
          customer = nil # there is no plan selected.
        end
      if customer != nil
        self.stripe_customer_token = customer.id
        save!
      end
    end
    rescue Stripe::CardError => e
      logger.error "Stripe error while creating customer: #{e.message}"
          errors.add :base, "There was a problem with your credit card.#{e.message}#{customer}"
          false
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
          errors.add :base, "There was a problem with your credit card.#{e.message}#{customer}"
          false
    
     rescue Stripe::AuthenticationError => e
      logger.error "Stripe error while creating customer: #{e.message}"
          errors.add :base, "There was a problem with your credit card.#{e.message}#{customer}"
          false
     rescue Stripe::ApiConnectionError => e
      logger.error "Stripe error while creating customer: #{e.message}"
          errors.add :base, "There was a problem with your credit card.#{e.message}#{customer}"
          false
       rescue Stripe::Error => e
      logger.error "Stripe error while creating customer: #{e.message}"
          errors.add :base, "There was a problem with your credit card.#{e.message}#{customer}"
          false
        end
    end
end
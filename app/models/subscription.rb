class Subscription < ApplicationRecord




  # def subscribe_to_wiki()
  #   create_subscription(find_customer)
  # end

  # private

  #   def find_customer
  #     if @user.stripe_customer_id
  #       retrieve_customer(@user.stripe_customer_id)
  #     else
  #       create_customer
  #     end
  #   end

  #   def retrieve_customer(id)
  #     Stripe::Customer.retrieve(id) 
  #   end

  #   def create_customer
  #     # Create customer in Stripe
  #     customer = Stripe::Customer.create(
  #       email: @email,
  #       description: @email,

  #       source: @token
  #     )

  #     # Update ActiveRecord
  #     @user.update(stripe_customer_id: customer.id)
  #     customer
  #   end

  #   def create_subscription(customer)
  #     byebug

  #     # Create subscription in Stripe for the current_user
  #     subscription = Stripe::Subscription.create(
  #       customer: customer.id,
  #       :items => [
  #         {
  #           :plan => "premium"
  #         },
  #       ]
  #     )

  #     # Update ActiveRecord
  #     sub = Subscription.create!(
  #       user_id: @user.id, 
  #       stripe_subscription_id: subscription.id,
  #       current_period_start: subscription.current_period_start,
  #       current_period_end: subscription.current_period_end
  #     )
  #     # sub.update(
  #     #   current_period_start: subscription.current_period_start,
  #     #   current_period_end: subscription.current_period_end
  #     # )

  #     subscription
  #   end
  

end

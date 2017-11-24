class Subscription < ApplicationRecord
  belongs_to :user

  def turn_on_autorenewal
    # customer = Stripe::Customer.retrieve(self.user.stripe_customer_id)
    sub = Stripe::Subscription.retrieve(stripe_subscription_id)
    sub.cancel_at_period_end = false
  end

  def turn_off_autorenewal
    sub = Stripe::Subscription.retrieve(stripe_subscription_id)
    sub.cancel_at_period_end = true
  end
  
end

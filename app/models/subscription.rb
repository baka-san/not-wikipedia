class Subscription < ApplicationRecord
  belongs_to :user

  def turn_on_autopay
    # byebug
    sub = Stripe::Subscription.retrieve(stripe_subscription_id)

    item_id = sub.items.data[0].id
    items = [{
      id: item_id,
      plan: "premium"
    }]

    sub.items = items
    sub.save

    self.autopay = true
    self.save
  end

  def turn_off_autopay
    # byebug
    sub = Stripe::Subscription.retrieve(stripe_subscription_id)
    sub.delete(at_period_end: true)

    self.autopay = false
    self.save
  end
  
end

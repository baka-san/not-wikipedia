FactoryGirl.define do
  factory :subscription do
    stripe_subscription_id "sub_subscription"
    user_id 
    current_period_start 1511622000 #2017,11,26
    current_period_end 3089469600 #2067,11,26
    plan "premium"
    user nil
  end
end

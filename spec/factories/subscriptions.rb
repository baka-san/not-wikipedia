FactoryGirl.define do
  factory :subscription do
    stripe_subscription_id "MyString"
    user_id 1
    current_period_start "2017-11-09 18:43:16"
    current_period_end "2017-11-09 18:43:16"
    plan "MyString"
    user nil
  end
end

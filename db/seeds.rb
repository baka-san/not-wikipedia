require 'faker'

# REMEMBER TO DELETE STRIPE TEST DATA AT https://dashboard.stripe.com/account/data

# Create Plans
plan = Stripe::Plan.create(
  :amount => 1500,
  :interval => 'month',
  :name => 'premium',
  :currency => 'usd',
  :id => 'premium'
)

# Plan.create(name: plan.name, stripe_id: plan.id, display_price: (plan.amount.to_f / 100)) 

# # Create Grant/admin
# grant = User.new(
#   username: 'Grant',
#   email: 'gsbackes@gmail.com', 
#   password: 'password',
#   password_confirmation: "password",
#   role: 'admin'
# )
# grant.skip_confirmation!
# grant.save!

# Create an admin user
admin = User.new(
  email:    "admin@gmail.com",
  username: "Admin",
  password: "password",
  password_confirmation: "password",
  role: "admin"
)
admin.skip_confirmation!
admin.save!

require 'random_data'

# Create a premium user
premium_user = User.new(
  email:    "premiumuser@gmail.com",
  username: "Premium User",
  password: "password",
  password_confirmation: "password",
  role: "premium"
)
premium_user.skip_confirmation!
premium_user.save!

# Create a premium user
standard_user = User.new(
  email:    "standarduser@gmail.com",
  username: "Standard User",
  password: "password",
  password_confirmation: "password"
)
standard_user.skip_confirmation!
standard_user.save!

users = User.all


#Create Subscriptions

# # Create Grant/admin subscription
# token = Stripe::Token.create(
#   :card => {
#     :number => "4242424242424242",
#     :exp_month => 12,
#     :exp_year => 2050,
#     :cvc => "123"
#   },
# )

# customer = Stripe::Customer.create(
#   email: grant.email,
#   description: grant.email,
#   source: token
# )

# grant.update(stripe_customer_id: customer.id)

# subscription = Stripe::Subscription.create(
#   customer: customer.id,
#   :items => [
#     {
#       :plan => "premium"
#     },
#   ]
# )

# # Update ActiveRecord
# sub = Subscription.create!(
#   user_id: grant.id, 
#   stripe_subscription_id: subscription.id,
#   current_period_start: subscription.current_period_start,
#   current_period_end: subscription.current_period_end
# )

# Create admin's subscription
token = Stripe::Token.create(
  :card => {
    :number => "4242424242424242",
    :exp_month => 12,
    :exp_year => 2050,
    :cvc => "123"
  },
)

customer = Stripe::Customer.create(
  email: admin.email,
  description: admin.email,
  source: token
)

admin.update(stripe_customer_id: customer.id)

subscription = Stripe::Subscription.create(
  customer: customer.id,
  :items => [
    {
      :plan => "premium"
    },
  ]
)

# Update ActiveRecord
sub = Subscription.create!(
  user_id: admin.id, 
  stripe_subscription_id: subscription.id,
  current_period_start: subscription.current_period_start,
  current_period_end: subscription.current_period_end
)


# Create premium user's subscription
token = Stripe::Token.create(
  :card => {
    :number => "4242424242424242",
    :exp_month => 12,
    :exp_year => 2050,
    :cvc => "123"
  },
)

customer = Stripe::Customer.create(
  email: premium_user.email,
  description: premium_user.email,
  source: token
)

premium_user.update(stripe_customer_id: customer.id)

subscription = Stripe::Subscription.create(
  customer: customer.id,
  :items => [
    {
      :plan => "premium"
    },
  ]
)

# Update ActiveRecord
sub = Subscription.create!(
  user_id: premium_user.id, 
  stripe_subscription_id: subscription.id,
  current_period_start: subscription.current_period_start,
  current_period_end: subscription.current_period_end
)




#Create Private Wiki Pages
Wiki.create!(
    title: "Admin's Private Wiki",
    body: "This wiki page is for Admin only.",
    user: admin,
    private: true
)

Wiki.create!(
    title: "Premium User's Private Wiki",
    body: "This is Premium User's wiki. Stay out!",
    user: premium_user,
    private: true
)

# Create Harry Potter Wiki Pages
6.times do
  sentence = Proc.new { Faker::HarryPotter.quote }

  Wiki.create!(
      title: Faker::HarryPotter.unique.book,
      body: RandomData.random_body(sentence),
      user_id: users.sample.id
    )
end

#Create Rick and Morty Wiki Pages
3.times do
  sentence = Proc.new { Faker::RickAndMorty.quote }

  Wiki.create!(
      title: Faker::RickAndMorty.unique.character,
      body: RandomData.random_body(sentence),
      user_id: users.sample.id
    )
end

#Create Star Wars Wiki Pages
3.times do
  sentence = Proc.new { Faker::StarWars.quote }

  Wiki.create!(
      title: Faker::StarWars.unique.character,
      body: RandomData.random_body(sentence),
      user_id: users.sample.id
    )
end

#Create Family Guy Wiki Pages
3.times do
  sentence = Proc.new { Faker::FamilyGuy.quote }

  Wiki.create!(
      title: Faker::FamilyGuy.unique.character,
      body: RandomData.random_body(sentence),
      user_id: users.sample.id
    )
end

#Create Simpsons Wiki Pages
3.times do
  sentence = Proc.new { Faker::Simpsons.quote }

  Wiki.create!(
      title: Faker::Simpsons.unique.character,
      body: RandomData.random_body(sentence),
      user_id: users.sample.id
    )
end


puts "Seed finished"
# puts "#{Plan.count} plans created"
puts "#{Subscription.count} subscriptions created"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"


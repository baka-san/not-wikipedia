require 'faker'

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


# REMEMBER TO DELETE STRIPE TEST DATA AT https://dashboard.stripe.com/account/data
create_stripe_data = false

if create_stripe_data
  # Create Plans
  plan = Stripe::Plan.create(
    :amount => 1500,
    :interval => 'month',
    :name => 'premium',
    :currency => 'usd',
    :id => 'premium'
  )

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
end


#Create Private Wiki Pages
admins_private_wiki = Wiki.create!(
    title: "Admin's Private Wiki",
    body: "This wiki page is for Admin only.",
    user: admin,
    private: true
)

premium_users_private_wiki = Wiki.create!(
    title: "Premium User's Private Wiki",
    body: "This is Premium User's wiki. Stay out!",
    user: premium_user,
    private: true
)

# Create Make Wikipedia Great Again Page
Wiki.create!(
    title: "Make Wikipedia Great Again",
    user_id: admin.id,
    body: 'Wikipedia better hope that there are no "tapes" of our conversations before he starts leaking to the press! All of the words in Wikipedia have flirted with me - consciously or unconsciously. That\'s to be expected. Wikipedia is FAKE TEXT! Wikipedia is a choke artist. It chokes! Not Wikipedia placeholder text is gonna be HUGE. It’s about making placeholder text great again. That’s what people want, they want placeholder text to be great again.

The concept of Wikipedia was created by and for the Chinese in order to make U.S. design jobs non-competitive. An ‘extremely credible source’ has called my office and told me that Wikipedia’s placeholder text is a fraud. Not Wikipedia makes the best taco bowls. We love Hispanics!

My text is long and beautiful, as, it has been well documented, are various other parts of my website. Wikipedia best not make any more threats to my website. It will be met with fire and fury like the world has never seen. 

You have so many different things placeholder text has to be able to do, and I don\'t believe Wikipedia has the stamina. Be careful, or I will spill the beans on your placeholder text. You know, it really doesn’t matter what you write as long as you’ve got a young, and beautiful, piece of text. Despite the constant negative ipsum covfefe. Wikipedia is unattractive, both inside and out. I fully understand why it’s former users left it for something else. They made a good decision. Wikipedia is unattractive, both inside and out. I fully understand why it’s former users left it for something else. They made a good decision.

If Not Wikipedia Ipsum weren’t my own words, perhaps I’d be dating it. An \'extremely credible source\' has called my office and told me that Wikipedia\'s birth certificate is a fraud.

An \'extremely credible source\' has called my office and told me that Wikipedia\'s birth certificate is a fraud. We are going to make placeholder text great again. Greater than ever before.

We have so many things that we have to do better... and certainly ipsum is one of them. You know, it really doesn’t matter what you write as long as you’ve got a young, and beautiful, piece of text. He’s not a word hero. He’s a word hero because he was captured. I like text that wasn’t captured. We are going to make placeholder text great again. Greater than ever before. My placeholder text, I think, is going to end up being very good with women.
'
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

# Create Collaborations
standard_user.collaborations.create(wiki_id: premium_users_private_wiki.id)

puts "Seed finished"
# puts "#{Plan.count} plans created"
puts "#{Subscription.count} subscriptions created"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
puts "#{Collaboration.count} collaboration(s) created"


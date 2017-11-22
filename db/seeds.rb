require 'faker'

# # Create Plans
# plan = Stripe::Plan.retrieve(id: 'premium')

# unless plan
#   plan = Stripe::Plan.create(
#     :amount => 1500,
#     :interval => 'month',
#     :name => 'premium',
#     :currency => 'usd',
#     :id => 'premium'
#   )
# end

# Plan.create(name: plan.name, stripe_id: plan.id, display_price: (plan.amount.to_f / 100)) 

# Create Grant/admin
grant = User.new(
  username: 'Grant',
  email: 'gsbackes@gmail.com', 
  password: 'password',
  password_confirmation: "password",
  role: 'admin'
)
grant.skip_confirmation!
grant.save!

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
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"


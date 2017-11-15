class AddIndexToUsersStripeCustomerId < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :stripe_customer_id, unique: true
  end
end

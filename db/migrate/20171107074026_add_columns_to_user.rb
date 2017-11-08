class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.string :stripe_customer_id
      t.datetime :subscribed_at
      t.datetime :subscription_expires_at
    end

    add_index :users, :subscribed_at, name: "subscribed_at_for_users"
    add_index :users, :subscription_expires_at, name: "expiring_subscritions_on_users"
  end
end

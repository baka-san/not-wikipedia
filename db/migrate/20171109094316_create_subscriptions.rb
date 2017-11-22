class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, foreign_key: true
      t.string :stripe_subscription_id, index: true
      t.integer :current_period_start
      t.integer :current_period_end
      t.string :plan, default: 'premium'

      t.timestamps
    end
  end
end

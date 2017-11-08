class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :stripe_id, null: false
      t.string :name, null: false
      t.decimal :display_price, null: false

      t.timestamps
    end
  end
end

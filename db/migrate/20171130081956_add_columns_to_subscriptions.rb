class AddColumnsToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :autopay, :boolean, default: true
  end
end

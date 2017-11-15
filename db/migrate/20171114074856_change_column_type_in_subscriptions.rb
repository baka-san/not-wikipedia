class ChangeColumnTypeInSubscriptions < ActiveRecord::Migration[5.1]
  def change
    change_column :subscriptions, :current_period_start, :integer
    change_column :subscriptions, :current_period_end, :integer
  end
end
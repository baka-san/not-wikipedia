class ChangeWikis < ActiveRecord::Migration[5.1]
  def change
    change_column :wikis, :private, :boolean, :default => false
  end
end

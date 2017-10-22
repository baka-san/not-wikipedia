class CreateWikis < ActiveRecord::Migration[5.1]
  def change
    create_table :wikis do |t|
      t.string :title
      t.text :body
      t.boolean :private
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

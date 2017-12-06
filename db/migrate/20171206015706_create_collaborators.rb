class CreateCollaborators < ActiveRecord::Migration[5.1]
  def change
    create_table :collaborators do |t|
      t.integer :wiki_id
      t.integer :user_id

      t.timestamps
    end

    add_index :collaborators, :id, unique: true
    add_index :collaborators, :wiki_id
    add_index :collaborators, :user_id
    add_index :collaborators, [:wiki_id, :user_id], unique: true
  end
  
end

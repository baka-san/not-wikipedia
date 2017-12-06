class CreateCollaborations < ActiveRecord::Migration[5.1]
  def change
    create_table :collaborations do |t|
      t.integer :wiki_id
      t.integer :collaborator_id

      t.timestamps
    end

    add_index :collaborations, :id, unique: true
    add_index :collaborations, :wiki_id
    add_index :collaborations, :collaborator_id
    add_index :collaborations, [:wiki_id, :collaborator_id], unique: true
  end

end

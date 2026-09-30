class CreateCharacterRelationships < ActiveRecord::Migration[7.2]
  def change
    create_table :character_relationships do |t|
      t.references :source_character,
                   null: false,
                   foreign_key: { to_table: :characters }

      t.references :target_character,
                   null: false,
                   foreign_key: { to_table: :characters }

      t.string :relation, null: false
      t.string :source_to_target_impression
      t.string :target_to_source_impression

      t.timestamps
    end

     add_index :character_relationships,
              [ :source_character_id, :target_character_id ],
              unique: true
  end
end

class AddUndirectedUniqueIndexToCharacterRelationships < ActiveRecord::Migration[7.2]
  def change
    add_index :character_relationships,
              "LEAST(source_character_id, target_character_id), GREATEST(source_character_id, target_character_id)",
              unique: true,
              name: "index_character_relationships_on_unordered_pair"
  end
end

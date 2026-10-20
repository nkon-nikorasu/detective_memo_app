class RemoveOldUniqueIndexFromCharacterRelationships < ActiveRecord::Migration[7.2]
  def change
    remove_index :character_relationships,
                 name: "idx_on_source_character_id_target_character_id_61ef0dac88"
  end
end

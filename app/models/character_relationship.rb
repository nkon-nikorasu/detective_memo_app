class CharacterRelationship < ApplicationRecord
  belongs_to :source_character, class_name: "Character"
  belongs_to :target_character, class_name: "Character"

  validates :relation, presence: true

  validate :characters_must_be_different
  validate :relationship_must_be_unique

  def other_character(character)
    case character
    when source_character
      target_character
    when target_character
      source_character
    end
  end

  def impression_from(character)
    case character
    when source_character
      source_to_target_impression
    when target_character
      target_to_source_impression
    end
  end

  private

  def characters_must_be_different
    return unless source_character_id == target_character_id

    errors.add(:target_character_id, "に同じ人物は指定できません")
  end

  def relationship_must_be_unique
    return if source_character_id.blank? || target_character_id.blank?

    duplicate = CharacterRelationship
                .where(source_character_id: target_character_id,
                       target_character_id: source_character_id)

    duplicate = duplicate.where.not(id: id) if persisted?

    return unless duplicate.exists?

    errors.add(:base, "この人物同士の関係性はすでに登録されています")
  end
end

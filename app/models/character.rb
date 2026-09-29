class Character < ApplicationRecord
  validates :name, presence: true, length: { maximum: 10 }
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 9999, allow_nil: true }
  validates :role, length: { maximum: 10 }
  validates :body, presence: true, length: { maximum: 5000 }
  enum gender: { man: 0, woman: 1, anonymous: 2 }
  belongs_to :incident
  has_many :source_relationships,
           class_name: "CharacterRelationship",
           foreign_key: :source_character_id,
           dependent: :destroy

  has_many :target_relationships,
           class_name: "CharacterRelationship",
           foreign_key: :target_character_id,
           dependent: :destroy

  def relationships
    CharacterRelationship.where(
      "source_character_id = :id OR target_character_id = :id",
      id: id
    )
  end
end

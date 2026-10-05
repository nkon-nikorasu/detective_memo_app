FactoryBot.define do
  factory :character_relationship do
    association :source_character, factory: :character
    association :target_character, factory: :character

    relation { "友人" }
    source_to_target_impression { "信頼している" }
    target_to_source_impression { "頼りになる" }
  end
end

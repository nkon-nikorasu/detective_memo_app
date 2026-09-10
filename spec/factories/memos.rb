FactoryBot.define do
  factory :memo do
    body { "犯人についての推理メモ" }
    tag { :deduction }
    association :incident
  end
end

FactoryBot.define do
  factory :incident do
    name { "殺人事件" }
    body { "事件についてのメモ" }
    tag { :murder }
    association :user
  end
end

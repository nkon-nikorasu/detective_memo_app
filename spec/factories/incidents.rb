FactoryBot.define do
  factory :incident do
    book { "容疑者Xの献身" }
    name { "殺人事件" }
    body { "事件についてのメモ" }
    tag { :murder }
    association :user
  end
end

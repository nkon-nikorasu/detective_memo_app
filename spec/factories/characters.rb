FactoryBot.define do
  factory :character do
    name { "田中太郎" }
    age { 30 }
    role { "容疑者" }
    body { "事件の容疑者の一人" }
    gender { :man }

    association :incident
  end
end

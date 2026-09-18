FactoryBot.define do
  factory :incident_time do
    year { 2026 }
    month { 10 }
    date { 10 }
    hour { 12 }
    minute { 30 }
    second { 30 }
    body { "事件が発生した" }

    association :incident
  end
end

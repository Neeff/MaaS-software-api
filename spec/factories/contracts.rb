FactoryBot.define do
  factory :contract do
    business_days { "" }
    init_hour { 1 }
    finish_hour { 1 }
    init_weekend_hour { 1 }
    finish_weekend_hour { 1 }
    service_id { nil }
  end
end

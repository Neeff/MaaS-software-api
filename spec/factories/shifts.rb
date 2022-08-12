FactoryBot.define do
  factory :shift do
    association :available_hour
    association :engineer
    starts_at { Time.now.to_s }
    ends_at { Time.now.to_s }
    date { '2022-08-09' }
  end
end

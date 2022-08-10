FactoryBot.define do
  factory :shift do
    engineer_id { nil }
    start_hour { "MyString" }
    end_hour { "MyString" }
    date { "2022-08-09" }
  end
end

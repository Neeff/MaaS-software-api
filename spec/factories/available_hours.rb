FactoryBot.define do
  factory :available_hour do
    association :service
    description { '19:00-00:00' }
    start_hour { '19' }
    end_hour { '00' }
    date { '2022-08-09' }
    week { 1 }
  end
end

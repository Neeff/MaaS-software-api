FactoryBot.define do
  factory :contract do
    business_days { {} }
    init_hour { 1 }
    finish_hour { 1 }
    init_weekend_hour { 1 }
    finish_weekend_hour { 1 }
    service_id { nil }

    trait :all_days do
      association :service
      business_days do
        { monday: true,
          tuesday: true,
          wednesday: true,
          thursday: true,
          friday: true,
          saturday: true,
          sunday: true }
      end

      init_hour { 19 }
      finish_hour { 0 }
      init_weekend_hour { 10 }
      finish_weekend_hour { 0 }
    end

    trait :no_weekends do
      association :service
      business_days do
        { monday: true,
          tuesday: true,
          wednesday: true,
          thursday: true,
          friday: true }
      end
      init_hour { 19 }
      finish_hour { 0 }
      init_weekend_hour { 10 }
      finish_weekend_hour { 0 }
    end
  end
end

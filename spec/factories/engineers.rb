require 'faker'

FactoryBot.define do
  factory :engineer do
    association :service
    name { Faker::Name.name }
    color { Faker::Color.hex_color }
  end
end

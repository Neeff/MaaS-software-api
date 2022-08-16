# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Engineer.all.delete_all
Shift.all.delete_all
EngineerAvailableHour.all.delete_all
AvailableHour.all.delete_all
Contract.all.delete_all
Service.all.delete_all

WEEKDAYS = { monday: true,
             tuesday: true,
             wednesday: true,
             thursday: true,
             friday: true,
             saturday: true,
             sunday: true }.freeze

service = Service.create(company_name: 'Recorrido.cl', weekly_hours: 0)
Contract.create(service_id: service.id,
                business_days: WEEKDAYS,
                init_hour: 19,
                finish_hour: 0,
                init_weekend_hour: 10,
                finish_weekend_hour: 0)
3.times do
  Engineer.create(name: Faker::Name.name, color: Faker::Color.hex_color, service_id: service.id)
end

today = Date.today.beginning_of_week
five_weeks_to_future = today + 5.week

(today..five_weeks_to_future).to_a.select(&:monday?).each do |date|
  Availability::Template.generate(service.contract, date)
end

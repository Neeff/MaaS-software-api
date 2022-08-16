namespace :available_hours do
  desc 'generate template by week for each service'
  task generate_templates_by_service: :environment do
    services = Services.all.includes(:contracts)
    services.each do |service|
      last_availabe_hour = AvailableHour.where(service_id: service).last
      date = last_availabe_hour.date + 1.week
      Availability::Template.generate(service.contract, date)
    end
  end
end

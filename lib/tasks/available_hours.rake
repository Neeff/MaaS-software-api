namespace :available_hours do
  desc 'generate template by week for each service'
  task generate_templates_by_service: :environment do
    services = Services.all.includes(:contracts)
    services.each do |service|
      Availability::Template.generate(service.contract)
    end
  end
end

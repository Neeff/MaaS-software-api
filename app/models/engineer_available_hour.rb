class EngineerAvailableHour < ApplicationRecord
  belongs_to :engineer
  belongs_to :available_hour

  def self.generate_intemediate_relation(service)
    structure = available_hours(service).map { |id| structure_engineer_available_hour(id, service) }
    structure.flatten!
    raise StandardError, 'Error structure is empty' if structure.empty?

    EngineerAvailableHour.import(structure, validate: false)
  rescue StandardError => e
    puts e.message
    []
  end

  def self.engineers_ids(service)
    service.engineers.pluck(:id)
  end

  def self.available_hours(service)
    number_of_week = Time.now.strftime('%U').to_i
    service.available_hours.where(week: number_of_week).pluck(:id)
  end

  def self.structure_engineer_available_hour(available_hour_id, service)
    engineers_ids(service).map { |id| { engineer_id: id, active: false, available_hour_id: available_hour_id } }
  end

  def self.records_by_service(service)
    includes(:available_hour, :engineer).where(available_hour: { service_id: service.id }).load
  end

  def self.update_time_availability(attrs)
    return [] if attrs.empty?

    updated_items = []
    attrs.each do |attr|
      record = find_by(engineer_id: attr[:available_hour][:engineer_id], available_hour_id: attr[:available_hour][:available_hour_id])
      record.update_columns(active: attr[:available_hour][:active])
      updated_items << record.available_hour
    end
    updated_items
  end
end

class AvailableHour < ApplicationRecord
  validates :description,
            :start_hour,
            :end_hour,
            :date,
            :week,
            presence: true

  belongs_to :service
  has_one  :shift
  has_many :engineer_available_hours
  has_many :engineers, through: :engineer_available_hours

  def self.allowed_parameters
    %i[engineer_id available_hour_id active]
  end

  def self.generate_available_hours(structure)
    AvailableHour.import(structure, validate: false)
  end

  def self.records_by_service(service, week)
    where(service_id: service.id, week: week).includes(engineers: :engineer_available_hours).load
  end

  def self.available_hours_by_service(service, week)
    where(service_id: service.id, week: week)
  end

  def self.available_hours_shifts_by_service(service, week)
    where(service_id: service.id, week: week).includes(shift: :engineer)
  end
end

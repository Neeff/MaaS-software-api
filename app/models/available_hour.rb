class AvailableHour < ApplicationRecord
  validates :description,
            :start_hour,
            :end_hour,
            :date,
            :week,
            presence: true

  belongs_to :service
  has_many :engineer_available_hours
  has_many :engineers, through: :engineer_available_hours

  def self.allowed_parameters
    %i[engineer_id available_hour_id active]
  end

  def self.generate_available_hours(structure)
    AvailableHour.import(structure, validate: false)
  end

  def self.records_by_service(service)
    where(service_id: service.id).includes(engineers: :engineer_available_hours).load
    # sql = "SELECT * FROM  available_hours INNER JOIN engineer_available_hours
    #       ON engineer_available_hours.available_hour_id = available_hours.id
    #       INNER JOIN engineers ON engineer_available_hours.engineer_id = engineers.id
    #       WHERE available_hours.service_id = #{service.id}"
    # ActiveRecord::Base.connection.execute(sql)
  end

  def self.available_hours_by_service(service)
    where(service_id: service.id)
  end
end

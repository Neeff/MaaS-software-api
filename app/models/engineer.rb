class Engineer < ApplicationRecord
  validates :name, presence: true

  belongs_to :service
  has_many :shifts, dependent: :destroy
  has_many :engineer_available_hours
  has_many :available_hours, through: :engineer_available_hours

  after_commit :assign_color, on: :create

  def self.available_hours_by_service(service, week)
    includes(:available_hours).where(available_hours: { service_id: service.id, week: week }, engineer_available_hours: { active: true } )
  end

  def self.count_by_service(service)
    where(service_id: service.id).size
  end

  def assign_color
    update_columns(color: Faker::Color.hex_color)
  end

  def available_hours_struct
    available_hours.map do |available_hour|
      starts_at = available_hour.date.to_time.change({ hour: available_hour.description.split('-').map(&:to_i).first })
      ends_at = available_hour.date.to_time.change({ hour: available_hour.description.split('-').map(&:to_i).second })
      { starts_at: starts_at, ends_at: ends_at }
    end
  end
end

class AvailableHour < ApplicationRecord
  belongs_to :service
  has_many :enginners_available_hours
  has_many :engineers, through: :enginners_available_hours
end

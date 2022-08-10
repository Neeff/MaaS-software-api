class Engineer < ApplicationRecord
  belongs_to :service
  has_many :shifts
  has_many :engineer_available_hours
  has_many :available_hours, through: :engineer_available_hours
end

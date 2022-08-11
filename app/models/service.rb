class Service < ApplicationRecord
  has_one :contract
  has_many :engineers
  has_many :available_hours
end

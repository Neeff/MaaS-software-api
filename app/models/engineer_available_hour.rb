class EngineerAvailableHour < ApplicationRecord
  belongs_to :engineer
  belongs_to :available_hour
end

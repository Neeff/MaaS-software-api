class Service < ApplicationRecord
  has_one :contract
  has_many :engineers
end

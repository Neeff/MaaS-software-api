class Contract < ApplicationRecord
  validates :business_days,
            :init_hour,
            :finish_hour,
            :init_weekend_hour,
            :finish_weekend_hour,
            presence: true

  belongs_to :service
end

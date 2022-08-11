class Engineer < ApplicationRecord
  validates :name, :color, presence: true

  belongs_to :service
  has_many :shifts, dependent: :destroy
  has_many :engineer_available_hours
  has_many :available_hours, through: :engineer_available_hours

  after_commit :assign_color, on: :create

  def assign_color
    update_columns(color: Faker::Color.hex_color)
  end
end

class Service < ApplicationRecord
  validates :company_name, presence: true

  has_one :contract, dependent: :destroy
  has_many :engineers, dependent: :destroy
  has_many :available_hours, dependent: :destroy
  has_many :shifts, through: :available_hours

  accepts_nested_attributes_for :engineers

  after_commit :associate_contract, on: :create

  def self.allowed_parameters
    [:company_name, engineers_attributes: [:name, :color]]
  end

  def associate_contract
    FactoryBot.create(:contract, :all_days, service_id: id)
  end
end

class Service < ApplicationRecord
  validate :number_of_assigned_engineers

  has_one :contract, dependent: :destroy
  has_many :engineers, dependent: :destroy
  has_many :available_hours, dependent: :destroy

  accepts_nested_attributes_for :engineers

  after_commit :associate_contract, on: :create

  def self.allowed_parameters
    [:company_name, engineers_attributes: [:name, :color]]
  end

  def associate_contract
    FactoryBot.create(:contract, :all_days, service_id: id)
  end

  private

  def number_of_assigned_engineers
    errors.add(:engineers, 'must associate at least one engineer and a maximum of three') if engineers.empty? || engineers.size > 3
  end
end

class Service < ApplicationRecord
  validates :company_name, presence: true

  has_one :contract, dependent: :destroy
  has_many :engineers, dependent: :destroy
  has_many :available_hours, dependent: :destroy
  has_many :shifts, through: :available_hours

  accepts_nested_attributes_for :engineers

  after_commit :associate_contract, on: :create

  def self.allowed_parameters
    [:company_name, engineers_attributes: [:name]]
  end

  def associate_contract
    FactoryBot.create(:contract, :all_days, service_id: id)
  end

  def weeks
    two_weeks_to_past = (Date.today - 2.week).beginning_of_week.to_time.strftime('%U').to_i
    five_weeks_to_future = (Date.today + 5.week).beginning_of_week.to_time.strftime('%U').to_i
    filter_array = (two_weeks_to_past..five_weeks_to_future).to_a
    available_hours.where(week: filter_array).pluck(:week).uniq
  end

  def current_week
    Date.today.beginning_of_week.to_time.strftime('%U').to_i
  end
end

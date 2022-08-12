require 'rails_helper'

RSpec.describe AvailableHour, type: :model do
  describe 'associations' do
    it('should belong to service') { should belong_to(:service) }
    it('should has many engineers') { should have_many(:engineers) }
    it('should has one shift') { should have_one(:shift) }
  end

  describe 'valid instance of AvailableHour' do
    it('return true') { expect(FactoryBot.build(:available_hour).valid?).to be_truthy }
    it('return false') { expect(FactoryBot.build(:available_hour, description: nil).valid?).to be_falsey }
  end

  describe '.available_hours_shifts_by_service' do
    let(:service) { FactoryBot.create(:service) }
    let(:engineer) { FactoryBot.create(:engineer, service_id: service.id) }
    let(:available_hour) { FactoryBot.create(:available_hour, service_id: service.id) }
    let(:shift) { FactoryBot.create(:shift, available_hour_id: available_hour.id) }
    let(:subject) { described_class }
    it 'return hours available and shift' do
      engineer
      shift
      data = subject.available_hours_shifts_by_service(service)
      expect(data.first).to be_instance_of(AvailableHour)
      expect(data.first.shift).to eq(shift)
    end
  end
end

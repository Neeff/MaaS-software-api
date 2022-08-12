require 'rails_helper'

RSpec.describe Availability::Shift do
  describe '#assignments_hours' do
    let(:service) { FactoryBot.create(:service) }
    let(:subject) { described_class.new(service) }
    let(:engineers) { FactoryBot.create_list(:engineer, 3, service_id: service.id) }
    it 'return array with availability hours of engineer' do
      engineers
      Availability::Template.generate(service.contract)
      EngineerAvailableHour.update_all(active: true)
      data = subject.send(:assignments_hours)
      expect(data.first).to include(:shift_structure)
    end
  end

  describe '#generate' do
    let(:service) { FactoryBot.create(:service) }
    let(:subject) { described_class.new(service) }
    let(:engineers) { FactoryBot.create_list(:engineer, 3, service_id: service.id) }
    it 'return collection of shifts' do
      engineers
      Availability::Template.generate(service.contract)
      EngineerAvailableHour.update_all(active: true)
      data = subject.generate
      expect(data).to be_instance_of(ActiveRecord::Import::Result)
      expect(data.num_inserts).to eq(1)
    end
  end
end

require 'rails_helper'

RSpec.describe Availability::Shift do
  describe '#engineer_availability' do
    let(:service) { FactoryBot.create(:service) }
    let(:subject) { described_class.new(service) }
    let(:engineers) { FactoryBot.create_list(:engineer, 3, service_id: service.id) }
    it 'return array with availability hours of engineer' do
      engineers
      Availability::Template.generate(service.contract)
      EngineerAvailableHour.update_all(active: true)
      data = subject.assignments_hours
      expect(data.first).to include(:shift_structure)
    end
  end
end

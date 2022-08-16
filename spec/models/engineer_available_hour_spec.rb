require 'rails_helper'

RSpec.describe EngineerAvailableHour, type: :model do
  describe 'associations' do
    it('should belongs to engineer') { should belong_to(:engineer) }
    it('should belongs to available hour') { should belong_to(:available_hour) }
  end

  describe '.engineers_ids' do
    let(:service) { FactoryBot.create(:service) }
    let(:engineer) { FactoryBot.create(:engineer, service_id: service.id) }
    let(:subject) { described_class }
    it 'return array of ids' do
      engineer
      expect(subject.engineers_ids(service)).to be_instance_of(Array)
      expect(subject.engineers_ids(service).first).to eq(engineer.id)
    end
  end

  describe '.available_hours' do
    let(:service) { FactoryBot.create(:service) }
    let(:available_hour) { FactoryBot.create(:available_hour, service_id: service.id, week: Time.now.strftime('%U').to_i) }
    let(:subject) { described_class }
    it 'return array of ids' do
      available_hour
      expect(subject.available_hours(service, available_hour.week)).to be_instance_of(Array)
      expect(subject.available_hours(service, available_hour.week).first).to eq(available_hour.id)
    end
  end

  describe '.structure_engineer_available_hour' do
    let(:service) { FactoryBot.create(:service) }
    let(:available_hour_id) { FactoryBot.create(:available_hour, service_id: service.id, week: Time.now.strftime('%U').to_i).id }
    let(:engineer) { FactoryBot.create(:engineer, service_id: service.id) }
    let(:subject) { described_class }
    it 'return array with hashs strcuture' do
      engineer
      data = subject.structure_engineer_available_hour(available_hour_id, service)
      expect(data).to be_instance_of(Array)
      expect(data.first.keys).to include(:engineer_id, :active, :available_hour_id)
    end
  end

  describe '.records_by_service' do
    let(:service) { FactoryBot.create(:service) }
    let(:available_hour) { FactoryBot.create(:available_hour, service_id: service.id, week: Time.now.strftime('%U').to_i) }
    let(:engineer_id) { FactoryBot.create(:engineer, service_id: service.id).id }
    let(:engineer_available_hour) do
      FactoryBot.create(:engineer_available_hour,
                        engineer_id: engineer_id,
                        available_hour_id: available_hour.id)
    end
    let(:subject) { described_class }
    it 'return ActiveRecordCollection' do
      engineer_available_hour
      expect(subject.records_by_service(service, available_hour.week).empty?).to be_falsey
    end
  end

  describe '.update_time_availability' do
    let(:service) { FactoryBot.create(:service) }
    let(:available_hour_id) { FactoryBot.create(:available_hour, service_id: service.id, week: Time.now.strftime('%U').to_i).id }
    let(:engineer_id) { FactoryBot.create(:engineer, service_id: service.id).id }
    let(:engineer_available_hour) do
      FactoryBot.create(:engineer_available_hour,
                        engineer_id: engineer_id,
                        available_hour_id: available_hour_id)
    end
    let(:subject) { described_class }
    it('return active true') do
      engineer_available_hour
      attrs = [{ available_hour: { available_hour_id: available_hour_id, engineer_id: engineer_id, active: true } }]
      expect(engineer_available_hour.active).to be_falsey
      subject.update_time_availability(attrs)
      engineer_available_hour.reload
      expect(engineer_available_hour.active).to be_truthy
    end
  end
end

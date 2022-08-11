require 'rails_helper'

RSpec.describe Availability::Template do
  describe '#active_days' do
    context 'when contract have all days of week' do
      contract = FactoryBot.create(:contract, :all_days)
      let(:subject) { described_class.new(contract) }
      it 'return array' do
        expect(subject.send(:active_days)).to be_instance_of(Array)
      end

      it 'return array with days' do
        expect(subject.send(:active_days)).to include('monday',
                                                      'tuesday',
                                                      'wednesday',
                                                      'thursday',
                                                      'friday',
                                                      'saturday',
                                                      'sunday')
      end
    end

    context 'when contract does not have weekends' do
      contract = FactoryBot.create(:contract, :no_weekends)
      let(:subject) { described_class.new(contract) }
      it 'return array' do
        expect(subject.send(:active_days)).to be_instance_of(Array)
      end

      it 'return array with days' do
        expect(subject.send(:active_days)).to include('monday',
                                                      'tuesday',
                                                      'wednesday',
                                                      'thursday',
                                                      'friday')
      end
    end
  end

  describe '#days' do
    context 'when contract have all days of week' do
      contract = FactoryBot.create(:contract, :all_days)
      let(:subject) { described_class.new(contract) }

      it 'return array with object dates' do
        expect(subject.send(:days).count).to eq(7)
        expect(subject.send(:days).first).to be_instance_of(Date)
      end
    end

    context 'when contract does not have weekends' do
      contract = FactoryBot.create(:contract, :no_weekends)
      let(:subject) { described_class.new(contract) }

      it 'return array with object dates' do
        expect(subject.send(:days).count).to eq(5)
        expect(subject.send(:days).first).to be_instance_of(Date)
      end
    end
  end

  describe '#make_structure_by_day' do
    context 'when contract have n days' do
      contract = FactoryBot.create(:contract, :all_days)
      let(:subject) { described_class.new(contract) }

      it 'return structure available hours' do
        data = subject.send(:make_structure_by_day)
        expect(data.first).to be_instance_of(Hash)
        expect(data.first[:description]).to eq('19:00-20:00')
      end
    end
  end

  describe '#generate' do
    it 'return collection of available hours' do
      contract = FactoryBot.create(:contract, :all_days)
      FactoryBot.create_list(:engineer, 3, service_id: contract.service_id)
      data = Availability::Template.generate(contract)
      expect(data).to be_instance_of(ActiveRecord::Import::Result)
      expect(data.num_inserts).to eq(1)
    end
  end
end

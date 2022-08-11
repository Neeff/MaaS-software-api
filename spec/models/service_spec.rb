require 'rails_helper'

RSpec.describe Service, type: :model do
  describe 'validations' do
    context 'when number of assigned engineers is less than 1 and greater than 3' do
      let(:service) { FactoryBot.create(:service) }
      it 'return service not valid' do
        expect { service }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Service, type: :model do
  describe 'associations' do
    it('should have many engineers') { should have_many(:engineers) }
    it('should have one contract ') { should have_one(:contract) }
    it('should have many available hurs') { should have_many(:available_hours) }
  end

  describe 'valid instance of Service' do
    it('return true') { expect(FactoryBot.build(:service).valid?).to be_truthy }
    it('return false') { expect(FactoryBot.build(:service, company_name: nil).valid?).to be_falsey }
  end
end

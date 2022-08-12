require 'rails_helper'

RSpec.describe Contract, type: :model do
  describe 'associations' do
    it('should belong to service') { should belong_to(:service) }
  end

  describe 'valid instance of Contract' do
    it('return true') { expect(FactoryBot.build(:contract,:all_days).valid?).to be_truthy }
    it 'return false' do
      expect(FactoryBot.build(:contract, :all_days, business_days: nil)
                       .valid?).to be_falsey
    end
  end
end

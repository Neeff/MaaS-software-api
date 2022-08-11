require 'rails_helper'

RSpec.describe Engineer, type: :model do
  describe 'associations' do
    it('should belong to service') { should belong_to(:service) }
    it('should have many shifts') { should have_many(:shifts) }
    it('should have many engineers available hours') { should have_many(:engineer_available_hours) }
  end

  describe 'valid instance of Engineer' do
    it('return true') { expect(FactoryBot.create(:engineer).valid?).to be_truthy }
  end
end

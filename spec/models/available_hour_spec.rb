require 'rails_helper'

RSpec.describe AvailableHour, type: :model do
  describe 'associations' do
    it('should belong to service') { should belong_to(:service) }
    it('should has many engineers') { should have_many(:engineers) }
  end

  describe 'valid instance of AvailableHour' do
    it('return true') { expect(FactoryBot.build(:available_hour).valid?).to be_truthy }
    it('return false') { expect(FactoryBot.build(:available_hour, description: nil).valid?).to be_falsey }
  end
end

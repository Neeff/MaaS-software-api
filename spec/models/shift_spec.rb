require 'rails_helper'

RSpec.describe Shift, type: :model do
  describe 'associations' do
    it('should belong to engineer') { should belong_to(:engineer) }
    it('should belong to available hour') { should belong_to(:available_hour) }
  end
end

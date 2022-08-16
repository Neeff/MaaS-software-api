require 'rails_helper'

RSpec.describe 'Shifts', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      headers = { 'Content-Type': 'application/json' }
      service_id = FactoryBot.create(:service).id
      week = Time.now.strftime('%U').to_i
      get "/shifts/#{service_id}/#{week}", headers: headers
      expect(response).to have_http_status(:success)
    end
  end
end

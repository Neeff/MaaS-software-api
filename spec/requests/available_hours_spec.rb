require 'rails_helper'

RSpec.describe 'AvailableHours', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      headers = { "Content-Type": 'application/json' }
      service_id = FactoryBot.create(:service).id
      week = Time.now.strftime('%U').to_i
      get "/available_hours/#{service_id}/#{week}", headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'returns http success' do
      available_hour_id = FactoryBot.create(:available_hour).id
      headers = { "Content-Type": 'application/json' }
      service_id = FactoryBot.create(:service).id
      week = Time.now.strftime('%U').to_i
      params = { service_id: service_id, week: week, available_hours: [] }.to_json
      patch "/available_hours/#{available_hour_id}", headers: headers, params: params
      expect(response).to have_http_status(:success)
    end
  end
end

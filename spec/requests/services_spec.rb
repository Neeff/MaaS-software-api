require 'rails_helper'

RSpec.describe 'Services', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      headers = { "Content-Type": 'application/json' }
      get '/services', headers: headers
      expect(response).to have_http_status(:success)
    end
  end
end

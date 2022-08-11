require 'rails_helper'

RSpec.describe "AvailableHours", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/available_hours/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/available_hours/update"
      expect(response).to have_http_status(:success)
    end
  end

end

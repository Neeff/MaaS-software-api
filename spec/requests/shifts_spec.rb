require 'rails_helper'

RSpec.describe "Shifts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/shifts/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/shifts/update"
      expect(response).to have_http_status(:success)
    end
  end

end

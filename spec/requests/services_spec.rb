require 'rails_helper'

RSpec.describe "Services", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/services/index"
      expect(response).to have_http_status(:success)
    end
  end

end

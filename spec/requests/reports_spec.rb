require 'rails_helper'

RSpec.describe "Reports", type: :request do
  describe "GET /reports" do
    it "renders index template" do
      get "/reports"
      expect(response.body).to include("Reports")
    end

    it "returns http success" do
      get "/reports"
      expect(response).to have_http_status(:success)
    end
  end
end
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

    describe "filters" do
      let!(:profile_list) { create_list(:profile, 3) }
      let!(:repo_1) {
        create(:repository,
          profile: profile_list.first, name: "test", tags: "one,two")
      }
      let!(:repo_2) {
        create(:repository,
          profile: profile_list.first, name: "test2", tags: "foo,bar")
      }

      it "filters report with a given tag" do
        get "/reports.json?tag=BAr"

        json_response = JSON.parse(response.body).first["repositories"]

        expect(response).to have_http_status(:success)
        expect(json_response.count).to eq(1)
        expect(json_response.first["id"]).to eq(repo_2.id)
      end
    end
  end

  describe "GET /reports/external" do
    let(:external_client) { double("External::Client") }

    it "returns the external reports" do
      allow(external_client).to receive(:fetch_profiles).and_return([])
      allow(external_client).to receive(:fetch_repositories).and_return([])

      get "/reports/external"

      expect(response).to have_http_status(:success)
    end
  end
end
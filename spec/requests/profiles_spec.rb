require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET /profiles" do
    it "renders template new" do
      get "/profiles/new"
      expect(response.body).to include("New Profile")
    end

    it "returns http success" do
      get "/profiles/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /profiles" do
    let(:profile_params) {
      {
        profile: {
          username: "foo-bar",
          repositories_attributes: [
            {
              name: "test repo",
              tags: "one,two"
            }
          ]
        }
      }
    }
    let(:create_profile) { post "/profiles", params: profile_params }

    it "creates a new profile with repositories" do
      expect{ create_profile }.to change{ Profile.count }.by(1)
      expect(Profile.last.username).to eq("foo-bar")
      expect(Profile.last.repositories.first.name).to eq("test repo")
    end

    it "prevents superuser flag to be set" do
      profile_params[:profile][:superuser] = true

      expect{ create_profile }.to change{ Profile.count }.by(1)
      expect(Profile.last.superuser).to be false
    end

    it "redirects to reports" do
      create_profile
      expect(response).to redirect_to(reports_path)
    end
  end
end
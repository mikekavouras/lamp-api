require 'rails_helper'

RSpec.describe Api::V1::OauthController, type: :controller do
  let(:user) { create(:user, anonymous: true) }
  let(:oauth_application) { create(:oauth_application) }
  let(:oauth_access_token) { create(:oauth_access_token, oauth_application: oauth_application, resource_owner: user) }

  describe "#create" do
    it "returns an invalid request when there is no application id" do
      post :create
      expect(response.body).to eq("invalid_request")
    end

    context "when the application id is specified" do
      before(:each) do
        allow(controller).to receive(:oauth_application_id).and_return(oauth_application.uid)
      end

      it "creates an access token" do
        expect {
          post :create
        }.to change(OauthAccessToken, :count).by(1)
      end

      it "creates a user" do
        expect {
          post :create
        }.to change(User, :count).by(1)
      end

      it "returns an access token" do
        post :create
        json = JSON.parse(response.body).with_indifferent_access
        expect(json[:access_token]).to be_present
        expect(json[:refresh_token]).to be_present
        expect(json[:token_type]).to eq('bearer')
        expect(json[:expires_in] > 83000).to be
      end
    end
  end

  describe "#revoke" do
    it "returns an invalid request when there is no application id" do
      post :revoke
      expect(response.body).to eq("invalid_request")
    end

    it "returns an invalid request when there is no authorization token" do
      allow(controller).to receive(:oauth_application_id).and_return(oauth_application.uid)
      post :revoke
      expect(response.body).to eq("invalid_grant")
    end

    context "when the application id and access token is specified" do
      before(:each) do
        allow(controller).to receive(:oauth_application_id).and_return(oauth_application.uid)
        allow(controller).to receive(:oauth_authorization_header).and_return("Bearer #{oauth_access_token.token}")
      end

      it "revokes the token" do
        post :revoke
        expect(oauth_access_token.reload).to be_revoked
      end
    end
  end

  describe "#refresh" do
    it "returns an invalid request when there is no application id" do
      post :refresh
      expect(response.body).to eq("invalid_request")
    end

    it "returns an invalid request when there is no authorization token" do
      allow(controller).to receive(:oauth_application_id).and_return(oauth_application.uid)
      post :refresh
      expect(response.body).to eq("invalid_grant")
    end

    context "when the application id and access token is specified" do
      before(:each) do
        allow(controller).to receive(:oauth_application_id).and_return(oauth_application.uid)
        allow(controller).to receive(:oauth_authorization_header).and_return("Bearer #{oauth_access_token.token}")
      end

      it "revokes the token" do
        post :refresh
        expect(oauth_access_token.reload).to be_revoked
      end

      it "creates a new token" do
        expect {
          post :refresh
        }.to change(OauthAccessToken, :count).by(1)
      end
    end
  end

end

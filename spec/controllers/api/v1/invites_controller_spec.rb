require 'rails_helper'

RSpec.describe Api::V1::InvitesController, type: :controller do
  let(:user) { create(:user, anonymous: true) }
  let(:device) { create(:device) }
  let(:user_device) { create(:user_device, user: user, device: device) }
  let(:invite) { create(:invite, user: user, device: device) }
  let(:valid_params) {{
    usage_limit: 1,
    expires_at: 1.day.from_now,
    id: user_device.id
  }}

  before(:each) do
    allow(Rails.application.secrets).to receive(:hashids_salt).and_return("MARK 9:50")
  end

  context "with a current user" do
    before(:each) do
      expect(controller).to receive(:require_oauth_application).and_return(true)
      expect(controller).to receive(:require_oauth_access_token).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe "POST #create" do
      it "creates an invite" do
        expect {
          post :create, params: valid_params
        }.to change(Invite, :count).by(1)

        expect(response).to be_ok
      end

      it "returns an invite" do
        post :create, params: valid_params
        json = JSON.parse(response.body).with_indifferent_access
        expect(json[:usage_limit]).to eq(1)
        expect(json[:token]).to eq(controller.send(:invite).token)
      end

      it "doesn't create an invite if there is no device" do
        post :create, params: { usage_limit: 1, expires_at: 1.day.from_now }
        expect(response.body).to eq('{"error":"no_device_id"}')
      end
    end

    describe "POST #accepts" do
      it "accepts an invite" do
        post :accept, params: { token: invite.token, name: "Your Mom's Lamp" }
        expect(response).to be_ok
      end

      it "returns an error if the device is not valid" do
        post :accept, params: { token: invite.token }
        expect(response.body).to eq('{"error":"invalid_device","errors":{"name":["can\'t be blank"]}}')
      end

      it "returns an error if there is no invite" do
        post :accept, params: { token: '' }
        expect(response.code).to eq("404")
        expect(response.body).to eq("{\"error\":\"invite_not_found\"}")
      end

      it "returns an error if the invite is revoked" do
        invite.update_attribute(:revoked_at, Time.now)
        post :accept, params: { token: invite.token }
        expect(response.body).to eq("{\"error\":\"invite_not_found\"}")
      end

      it "returns an error if the invite is expired" do
        invite.update_attribute(:expires_at, Time.now)
        post :accept, params: { token: invite.token }
        expect(response.body).to eq("{\"error\":\"invite_not_found\"}")
      end

      it "returns an error if the invite has reached the usage limit" do
        invite.update_attributes(usage_limit: 1, usage_count: 1)
        post :accept, params: { token: invite.token }
        expect(response.body).to eq("{\"error\":\"invite_not_found\"}")
      end

      it "increments the usage count" do
        post :accept, params: { token: invite.token, name: "Your Mom's Lamp" }
        expect(invite.reload.usage_count).to eq(1)
      end

      it "creates a user device" do
        expect {
          post :accept, params: { token: invite.token, name: "Your Mom's Lamp" }
        }.to change(UserDevice, :count).by(1)
      end
    end
  end
end

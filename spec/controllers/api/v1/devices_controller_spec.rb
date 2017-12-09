require 'rails_helper'

RSpec.describe Api::V1::DevicesController, type: :controller do
  let(:user) { create(:user, anonymous: true) }
  let(:device) { create(:device) }

  context "with a current user" do
    before(:each) do
      expect(controller).to receive(:require_oauth_application).and_return(true)
      expect(controller).to receive(:require_oauth_access_token).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe "POST #create" do
      it "creates a user device" do
        name = "Your Mom's Lamp"
        post :create, params: { particle_id: device.particle_id, name: name }
        json = JSON.parse(response.body).with_indifferent_access
        expect(json[:id]).to be_present
        expect(json[:name]).to eq(name)
        expect(response).to be_ok
      end

      it "returns an existing user device if one already exists" do
        user_device =create(:user_device, user: user, device: device)
        name = "Your Mom's Lamp"
        post :create, params: { particle_id: device.particle_id, name: name }
        json = JSON.parse(response.body).with_indifferent_access
        expect(json[:id]).to eq(user_device.id)
       end

      it "returns an error if it is invalid" do
        post :create, params: { particle_id: device.particle_id, name: nil }
        json = JSON.parse(response.body).with_indifferent_access
        expect(json[:error]).to eq("invalid_device")
        expect(response.code).to eq("422")
      end
    end

    describe "POST #presence" do
      it "updates the device presence value" do
        expect(device.presence).to be(false)
        post :presence, params: { particle_id: device.particle_id, presence: true }
        device.reload
        expect(device.presence).to be(true)
        expect(device.last_heard_at).not_to be_nil
        expect(response.code).to eq("200")
      end

      it "doesn't update last_heard at when false" do
        post :presence, params: { particle_id: device.particle_id, presence: false }
        device.reload
        expect(device.presence).to be(false)
        expect(device.last_heard_at).to be_nil
        expect(response.code).to eq("200")
      end
    end

    context "with an existing user_device" do
      let!(:user_device) { create(:user_device, user: user, device: device) }

      describe "GET #index" do
        it "gets a list of devices" do
          user_device
          get :index
          json = JSON.parse(response.body).with_indifferent_access
          expect(json[:user_devices][0][:id]).to eq(user_device.id)
          expect(response).to be_ok
        end
      end

      describe "GET #show" do
        it "gets a device" do
          get :show, params: { id: user_device.id }
          json = JSON.parse(response.body).with_indifferent_access
          expect(json[:id]).to eq(user_device.id)
          expect(json[:name]).to eq(user_device.name)
          expect(json[:device][:particle_id]).to eq(device.particle_id)
          expect(response).to be_ok
        end

        it "returns an error when there is no device" do
          get :show, params: { id: -1 }
          expect(response.body).to eq("{\"error\":\"device_not_found\"}")
        end
      end

      describe "DELETE #destroy" do
        it "deletes a device" do
          expect {
            delete :destroy, params: { id: user_device.id }
          }.to change(UserDevice, :count).by(-1)

          expect(response).to be_ok
        end
      end

      describe "POST #reset" do
        it "deletes all devices" do
          expect {
            post :reset, params: { id: user_device.id }
          }.to change(UserDevice, :count).by(-1)

          expect(response).to be_ok
        end

        it "revokes all invites for the device"
      end
    end
  end
end

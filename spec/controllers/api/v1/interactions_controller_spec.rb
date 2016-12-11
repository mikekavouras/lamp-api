require 'rails_helper'

RSpec.describe Api::V1::InteractionsController, type: :controller do
  let(:user) { create(:user, anonymous: true) }
  let(:device) { create(:device) }
  let(:user_device) { create(:user_device, user: user, device: device) }
  let(:interaction) { create(:interaction, user: user, user_device: user_device) }
  let(:valid_params) {{
    user_device_id: user_device.id,
    name: "Cute",
    description: "I glow this to say sup",
    red: 100,
    green: 0,
    blue: 0,
    pattern: 'glow',
  }}

  context "with a current user" do
    before(:each) do
      expect(controller).to receive(:require_oauth_application).and_return(true)
      expect(controller).to receive(:require_oauth_access_token).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe "POST #create" do
      it "creates an interaction" do
        expect {
          post :create, params: valid_params
        }.to change(Interaction, :count).by(1)

        expect(response).to be_ok
      end

      it "returns an interaction" do
        post :create, params: valid_params
        json = JSON.parse(response.body).with_indifferent_access
        expect(json[:data][:attributes][:name]).to eq("Cute")
      end

      it "doesn't create an interaction if there is no device" do
        valid_params.delete(:user_device_id)
        post :create, params: valid_params
        expect(response.body).to eq('{"error":"no_device_id"}')
      end
    end

    describe "GET #index" do
      it "returns a list of interactions" do
        interaction
        get :index
        json = JSON.parse(response.body).with_indifferent_access
        expect(json[:data][0][:attributes][:name]).to eq("Spooky")
      end
    end

    describe "GET #show" do
      it "returns an interaction" do
        get :show, params: { id: interaction.id }
        json = JSON.parse(response.body).with_indifferent_access
        expect(json[:data][:attributes][:name]).to eq("Spooky")
      end
    end

    describe "PATCH #update" do
      it "updates an interaction" do
        valid_params[:id] = interaction.id
        patch :update, params: valid_params
        json = JSON.parse(response.body).with_indifferent_access
        expect(json[:data][:attributes][:name]).to eq("Cute")
      end
    end

    describe "DELETE #destroy" do
      it "deletes an interaction" do
        interaction
        expect {
          delete :destroy, params: { id: interaction.id }
        }.to change(Interaction, :count).by(-1)

        expect(response).to be_ok
      end
    end

    describe "POST #event" do
      it "creates an event for an interaction" do
        interaction
        expect {
          post :event, params: { id: interaction.id }
        }.to change(Event, :count).by(1)

        expect(response).to be_ok
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Api::V1::SharesController, type: :controller do
  let(:photo) { create(:photo, user: user) }
  let(:user) { create(:user, anonymous: true) }
  let(:device) { create(:device) }
  let(:user_device) { create(:user_device, user: user, device: device) }
  let(:interaction) { create(:interaction, user: user, user_device: user_device, photo: photo) }
  let(:share) { create(:share, interaction: interaction, user: user) }

  let(:valid_params) {{
    interaction_id: interaction.id
  }}

  before(:each) do
    allow(Rails.application.secrets).to receive(:share_hashids_salt).and_return("MARK 9:50")
  end

  context "with a current user" do
    before(:each) do
      expect(controller).to receive(:require_oauth_application).and_return(true)
      expect(controller).to receive(:require_oauth_access_token).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe "POST #create" do
      it "creates a share" do
        expect {
          post :create, params: valid_params
        }.to change(Share, :count).by(1)

        expect(response).to be_ok
      end

      it "returns a share" do
        post :create, params: valid_params
        json = JSON.parse(response.body).with_indifferent_access
        expect(json[:interaction][:name]).to eq(interaction.name)
      end

      it "doesn't create a share if there is no device" do
        valid_params.delete(:interaction_id)
        post :create, params: valid_params
        expect(response.body).to eq('{"error":"no_interaction_id"}')
      end
    end

    describe "DELETE #destroy" do
      it "deletes a share" do
        share
        expect {
          delete :destroy, params: { id: share.id }
        }.to change(Share, :count).by(-1)

        expect(response).to be_ok
      end
    end
  end
end

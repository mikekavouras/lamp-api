require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  let(:user) { create(:user, anonymous: true) }
  let(:device) { create(:device) }
  let(:user_device) { create(:user_device, user: user, device: device) }
  let(:interaction) { create(:interaction, user: user, user_device: user_device) }
  let(:event) { create(:event, user: user, interaction: interaction) }

  context "with a current user" do
    before(:each) do
      expect(controller).to receive(:require_oauth_application).and_return(true)
      expect(controller).to receive(:require_oauth_access_token).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe "GET #index" do
      it "returns a list of events" do
        event
        get :index
        json = JSON.parse(response.body).with_indifferent_access
        expect(json[:data][0][:id]).to eq("#{event.id}")
      end
    end
  end
end

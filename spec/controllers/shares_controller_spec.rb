require 'rails_helper'

RSpec.describe SharesController, type: :controller do
  render_views

  let(:user) { create(:user, anonymous: true) }
  let(:device) { create(:device) }
  let(:user_device) { create(:user_device, user: user, device: device) }
  let(:photo) { create(:photo, user: user) }
  let(:interaction) { create(:interaction, user: user, user_device: user_device, photo: photo) }
  let(:share) { create(:share, interaction: interaction, user: user) }

  before(:each) do
    allow(Rails.application.secrets).to receive(:share_hashids_salt).and_return("MARK 9:50")
  end

  describe "GET #show" do
    it "shows the interaction" do
      get :show, params: { token: share.token }
      expect(response).to be_ok
    end
  end

  describe "POST #create" do
    it "is successful" do
      post :create, params: { token: share.token }
      expect(response).to be_redirect
    end

    it "creates an event" do
      expect {
        post :create, params: { token: share.token }
      }.to change(Event, :count).by(1)
    end

    it "returns an error if there is no share" do
      expect {
        post :create, params: { token: "NOTATOKEN" }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

require 'rails_helper'

RSpec.describe Api::V1::PhotosController, type: :controller do
  let(:user) { create(:user, anonymous: true) }
  let(:photo) { create(:photo, user: user) }
  let(:valid_params) {{
    filename: 'iguana.jpg',
    ext: '.jpg',
    original_width: 640,
    original_height: 783,
    sha: 'e360eb2880f83e6c0fb036d206121adb8ae25f0c',
    mime_type: 'image/jpeg'
  }}

  context "with a current user" do
    before(:each) do
      expect(controller).to receive(:require_oauth_application).and_return(true)
      expect(controller).to receive(:require_oauth_access_token).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
      allow(Rails.application.secrets).to receive(:aws_bucket).and_return('bucket')
      allow(Rails.application.secrets).to receive(:aws_access_key_id).and_return('key')
      allow(Rails.application.secrets).to receive(:aws_secret_access_key).and_return('secret')
    end

    describe "GET #index" do
      it "returns a list of photos" do
        photo
        get :index
        json = JSON.parse(response.body).with_indifferent_access
        expect(json[:data][0][:attributes][:filename]).to eq('iguana.jpg')
      end
    end

    describe "POST #create" do
      it "creates an photo" do
        expect {
          post :create
        }.to change(Photo, :count).by(1)

        expect(response).to be_ok
      end

      it "returns upload params" do
        post :create
        json = JSON.parse(response.body).with_indifferent_access
        expect(json[:key]).to match('test/uploads')
      end
    end

    describe "PATCH #update" do
      it "updates an photo" do
        valid_params[:id] = photo.id
        patch :update, params: valid_params
        json = JSON.parse(response.body).with_indifferent_access
        expect(json[:data][:attributes][:filename]).to eq("iguana.jpg")
      end
    end
  end
end

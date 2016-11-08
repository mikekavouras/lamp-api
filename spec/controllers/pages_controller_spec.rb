require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "#ping" do
    it "returns pong" do
      get :ping
      expect(response.body).to eq("pong")
    end
  end
end

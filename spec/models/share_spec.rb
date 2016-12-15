require 'rails_helper'

RSpec.describe Share, type: :model do
  let(:user) { create(:user, anonymous: true) }
  let(:device) { create(:device) }
  let(:user_device) { create(:user_device, user: user, device: device) }
  let(:interaction) { create(:interaction, user: user, user_device: user_device) }
  let(:share) { create(:share, interaction: interaction, user: user) }

  it { should belong_to(:user) }
  it { should belong_to(:interaction) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:interaction) }

  context "salt is good" do
    before(:each) do
      expect(Rails.application.secrets).to receive(:share_hashids_salt).and_return("MARK 9:50")
    end

    it "calculates a token" do
      expect(share).to receive(:id).and_return(1)
      expect(share.token).to eq("0w6zB8ONGdpbmPxZ")
    end

    it "finds a record by hash" do
      fake_scope = double
      fake_where = double
      expect(fake_scope).to receive(:where).with({id: 1}).and_return(fake_where)
      expect(fake_where).to receive(:first).and_return(:share)
      expect(Share).to receive(:active).and_return(fake_scope)
      Share.find_by_token("0w6zB8ONGdpbmPxZ")
    end

    it "returns nil when trying to find a record by an invalid hash" do
      result = Share.find_by_token('')
      expect(result).to be(nil)
    end
  end
end

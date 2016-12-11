require 'rails_helper'

RSpec.describe Invite, type: :model do
  let(:device) { create(:device) }
  let(:invite) { create(:invite, device: device) }

  it { should belong_to(:user) }
  it { should belong_to(:device) }

  context "salt is good" do
    before(:each) do
      expect(Rails.application.secrets).to receive(:hashids_salt).and_return("MARK 9:50")
    end

    it "calculates a token" do
      expect(invite).to receive(:id).and_return(1)
      expect(invite.token).to eq("8ONGdp")
    end

    it "finds a listing by hash" do
      fake_scope = double
      fake_where = double
      expect(fake_scope).to receive(:where).with({id: 1}).and_return(fake_where)
      expect(fake_where).to receive(:first).and_return(:invite)
      expect(Invite).to receive(:active).and_return(fake_scope)
      Invite.find_by_token("8ONGdp")
    end

    it "returns nil when trying to find a listing by an invalid hash" do
      result = Invite.find_by_token('')
      expect(result).to be(nil)
    end
  end
end

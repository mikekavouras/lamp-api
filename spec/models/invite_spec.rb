require 'rails_helper'

RSpec.describe Invite, type: :model do
  let(:invite) { create(:invite) }

  it { should belong_to(:user) }

  it "calculates a token" do
    expect(Rails.application.secrets).to receive(:hashids_salt).and_return("MARK 9:50")
    expect(invite).to receive(:id).and_return(1)
    expect(invite.token).to eq("8ONGdp")
  end
end

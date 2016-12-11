require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:interaction) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:interaction) }

  let(:user) { create(:user, anonymous: true) }
  let(:device) { create(:device) }
  let(:user_device) { create(:user_device, user: user, device: device) }
  let(:interaction) { create(:interaction, user: user, user_device: user_device) }
  let(:event) { create(:event, user: user, interaction: interaction) }

  describe "#perform" do
    it "updates the status" do
      expect(device).to receive(:glow).and_return("1")
      event.perform
      expect(event.status).to eq("success")
    end

    it "glows the device" do
      expect(device).to receive(:glow).and_return("1")
      event.perform
    end
  end
end

require 'rails_helper'

RSpec.describe OauthAccessToken, type: :model do
  it { should belong_to(:oauth_application) }
  it { should belong_to(:resource_owner) }

  let(:user) { create(:user, anonymous: true) }
  let(:oauth_application) { create(:oauth_application) }
  let(:oauth_access_token) { create(:oauth_access_token, oauth_application: oauth_application, resource_owner: user) }

  it "revokes the token" do
    oauth_access_token.revoke
    expect(oauth_access_token.reload).to be_revoked
  end

  it "is expired" do
    oauth_access_token.expires_at = 1.hour.ago
    expect(oauth_access_token).to be_expired
  end

  it "is revoked" do
    oauth_access_token.revoke
    expect(oauth_access_token).to be_revoked
  end
end

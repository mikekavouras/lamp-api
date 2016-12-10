require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:user_devices) }
  it { should have_many(:devices) }
  it { should have_many(:photos) }
  it { should have_many(:apns_tokens) }
  it { should have_many(:invites) }
  it { should have_many(:interactions) }
  it { should have_many(:oauth_access_tokens) }
end

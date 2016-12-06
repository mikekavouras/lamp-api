require 'rails_helper'

RSpec.describe OauthApplication, type: :model do
  it { should have_many(:oauth_access_tokens) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:redirect_uri) }
end

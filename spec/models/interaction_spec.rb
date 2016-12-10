require 'rails_helper'

RSpec.describe Interaction, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:device) }
  it { should belong_to(:photo) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:device) }
end

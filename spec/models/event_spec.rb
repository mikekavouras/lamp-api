require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:interaction) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:interaction) }
end

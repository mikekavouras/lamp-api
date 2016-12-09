require 'rails_helper'

RSpec.describe UserDevice, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:device) }
  it { should belong_to(:invite) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:device) }
  it { should validate_presence_of(:name) }
end

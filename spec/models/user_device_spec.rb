require 'rails_helper'

RSpec.describe UserDevice, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:device) }
  it { should belong_to(:invite) }
end

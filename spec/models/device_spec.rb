require 'rails_helper'

RSpec.describe Device, type: :model do
  let(:device) { create(:device) }
  let(:particle_device) { JSON.parse("{\"id\":\"53ff6d066667574818431267\",\"name\":\"Doug\",\"last_app\":null,\"last_ip_address\":\"69.148.45.165\",\"last_heard\":\"2016-11-13T20:44:22.810Z\",\"product_id\":0,\"connected\":true,\"platform_id\":0,\"cellular\":false,\"status\":\"normal\",\"variables\":{},\"functions\":[\"glow\"],\"cc3000_patch_version\":\"1.29\"}", object_class: TestStruct) } # "\""

  it { should have_many(:user_devices) }
  it { should have_many(:users) }

  it "imports the params" do
    device.import(particle_device)
    expect(device.reload.name).to eq("Doug")
  end
end

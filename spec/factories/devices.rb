FactoryGirl.define do
  factory :device do
    sequence(:particle_id) { |i| "Photon-#{i}" }
    sequence(:params) { |i| "{\"id\":\"Photon-#{i}\",\"name\":\"Doug\",\"last_app\":null,\"last_ip_address\":\"69.148.45.165\",\"last_heard\":\"2016-11-13T20:44:22.810Z\",\"product_id\":0,\"connected\":true,\"platform_id\":0,\"cellular\":false,\"status\":\"normal\",\"variables\":{},\"functions\":[\"glow\"],\"cc3000_patch_version\":\"1.29\"}" }
    presence false
  end
end

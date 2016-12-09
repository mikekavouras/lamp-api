FactoryGirl.define do
  factory :user_device do
    sequence(:name) { |i| "Device-#{i}" }
    direct false
  end
end

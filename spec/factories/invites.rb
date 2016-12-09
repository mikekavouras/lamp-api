FactoryGirl.define do
  factory :invite do
    usage_count 0
    usage_limit 1
    expires_at 1.day.from_now
    revoked_at nil
  end
end

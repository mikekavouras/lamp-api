FactoryGirl.define do
  factory :oauth_application do
    name "Cheeseburger"
    redirect_uri "https://lamp.engineering"
    scopes "read write arithmetic"
  end
end

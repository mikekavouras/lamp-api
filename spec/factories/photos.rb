FactoryGirl.define do
  factory :photo do
    filename 'iguana.jpg'
    ext '.jpg'
    original_width 640
    original_height 783
    sha 'e360eb2880f83e6c0fb036d206121adb8ae25f0c'
    mime_type 'image/jpeg'
    ip_address "1.2.3.4"
  end
end

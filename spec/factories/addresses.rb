FactoryGirl.define do
  factory :address do
    address_type 1
    street_address "MyString"
    secondary_address "MyString"
    city "MyString"
    state "MyString"
    zip "MyString"
    country "MyString"
    address_owner nil
  end
end

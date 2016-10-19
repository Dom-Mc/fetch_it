# == Schema Information
#
# Table name: addresses
#
#  id                 :integer          not null, primary key
#  address_type       :integer          default("residence"), not null
#  street_address     :string           default(""), not null
#  secondary_address  :string
#  city               :string           default("San Francisco"), not null
#  state              :string           default("California"), not null
#  zip                :string           default(""), not null
#  country            :string           default("United States"), not null
#  address_owner_type :string
#  address_owner_id   :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

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

# == Schema Information
#
# Table name: phones
#
#  id               :integer          not null, primary key
#  phone_number     :string(10)       default(""), not null
#  phone_type       :integer          default("mobile"), not null
#  ext              :string
#  phone_owner_type :string
#  phone_owner_id   :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :phone do
    phone_type Faker::Number.between(0, 2)
    phone_number Faker::Number.number(10)
    # ext (optional)
    user
    service
    order
  end
end

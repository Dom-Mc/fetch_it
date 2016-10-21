# == Schema Information
#
# Table name: recipients
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  order_id   :integer
#  first_name :string           default(""), not null
#  last_name  :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :recipient do
    user
    order
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
  end
end

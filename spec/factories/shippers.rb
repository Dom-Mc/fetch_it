# == Schema Information
#
# Table name: shippers
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
  factory :shipper do
    user nil
    order nil
    first_name "MyString"
    last_name "MyString"
  end
end

# == Schema Information
#
# Table name: services
#
#  id           :integer          not null, primary key
#  service_name :string           default(""), not null
#  description  :text             default(""), not null
#  price        :decimal(, )      default(0.0), not null
#  order_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :service do
    service_name %w(ASAP Express 4-Hour 8-Hour).shuffle.first
    description Faker::Lorem.paragraph(2)
    price { rand() * 100 }
  end
end

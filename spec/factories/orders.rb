# == Schema Information
#
# Table name: orders
#
#  id                    :integer          not null, primary key
#  order_total           :decimal(, )      default(0.0), not null
#  number_of_items       :string           default("1"), not null
#  special_instructions  :string
#  shipping_reference    :string
#  estimated_weight      :string           default("1"), not null
#  signature_requirement :integer          default("No Signature"), not null
#  pickup_date           :date
#  pickup_time           :string
#  service_id            :integer
#  account_id            :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

FactoryGirl.define do
  factory :order do
    user
    service
    shipping_date Faker::Date.between(2.days.ago, Date.today)
    # order_total (default - 0.0)
    # number_of_items (default - "1")
    # special_instructions (optional)
    # shipping_reference (optional)
    # estimated_weight (default - "1")
    # signature_requirement (default - "No-Signature")
  end

end

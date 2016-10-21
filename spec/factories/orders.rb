# == Schema Information
#
# Table name: orders
#
#  id                    :integer          not null, primary key
#  total_charge          :decimal(, )      default(0.0), not null
#  number_of_items       :string           default("1"), not null
#  special_instructions  :string
#  shipping_reference    :string
#  estimated_weight      :string           default("1"), not null
#  signature_requirement :integer          default("no_signature"), not null
#  user_id               :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

FactoryGirl.define do
  factory :order do
    user
    service
    # total_charge (default - 0.0)
    # number_of_items (default - "1")
    # special_instructions (optional)
    # shipping_reference (optional)
    # estimated_weight (default - "1")
    # signature_requirement (default - "No-Signature")
  end

end

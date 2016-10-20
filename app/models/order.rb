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

class Order < ApplicationRecord
  enum signature_requirement: { "No Signature" => 0, "Direct Signature" => 1, "Indirect Signature" => 2 }
  
  has_one :recipient, inverse_of: :order
  belongs_to :service, inverse_of: :orders
  has_one :shipper, inverse_of: :order
  belongs_to :user, inverse_of: :orders

end

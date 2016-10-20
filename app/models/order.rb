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

  # def name_of_service=(service_id)
  #   self.service = Service.find(service_id)
  # end

  def shipper_attributes=(shipper_attributes)
    shipper = self.build_shipper(
      first_name: shipper_attributes[:first_name],
       last_name: shipper_attributes[:last_name]
    )
    shipper.build_phone(
      phone_number: shipper_attributes[:phone][:phone_number],
        phone_type: 0,#shipper_attributes[:phone][:phone_type],
               ext: shipper_attributes[:phone][:ext]
    )
    shipper.build_address(
      secondary_address: shipper_attributes[:address][:secondary_address],
         street_address: shipper_attributes[:address][:street_address],
           address_type: shipper_attributes[:address][:address_type],
                    zip: shipper_attributes[:address][:zip]
    )
  end

  def recipient_attributes=(recipient_attributes)
    recipient = self.build_recipient(
      first_name: recipient_attributes[:first_name],
       last_name: recipient_attributes[:last_name]
    )
    recipient.build_phone(
      phone_number: recipient_attributes[:phone][:phone_number],
        phone_type: 0,#recipient_attributes[:phone][:phone_type],
               ext: recipient_attributes[:phone][:ext]
    )
    recipient.build_address(
      secondary_address: recipient_attributes[:address][:secondary_address],
         street_address: recipient_attributes[:address][:street_address],
           address_type: recipient_attributes[:address][:address_type],
                    zip: recipient_attributes[:address][:zip]
    )
  end

end

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

  SALES_TAX = 8.75

  has_one :recipient, inverse_of: :order
  belongs_to :service, inverse_of: :orders
  has_one :shipper, inverse_of: :order
  belongs_to :user, inverse_of: :orders


  validates :estimated_weight, presence: true,
  numericality: { greater_than_or_equal_to: 1 }

  validates :number_of_items, presence: true,
  numericality: { greater_than_or_equal_to: 1 }

  validates :service, presence: true

  validates :shipping_reference, length: { maximum: 50 },
                                 allow_nil: true

  validates :signature_requirement, presence: true,
                                    inclusion: { within: ["No Signature", "Indirect Signature", "Direct Signature"] }

  validates :special_instructions, length: { maximum: 2000 },
                allow_nil: true


  validates :total_charge, presence: true
                           #numericality: { greater_than_or_equal_to: 0 }

  validates :user, presence: true



  def shipper_attributes=(shipper_attributes)
    shipper = self.build_shipper(
      first_name: shipper_attributes[:first_name],
       last_name: shipper_attributes[:last_name]
    )
    shipper.build_phone(
      phone_number: shipper_attributes[:phone][:phone_number],
        phone_type: shipper_attributes[:phone][:phone_type],
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
        phone_type: recipient_attributes[:phone][:phone_type],
               ext: recipient_attributes[:phone][:ext]
    )
    recipient.build_address(
      secondary_address: recipient_attributes[:address][:secondary_address],
         street_address: recipient_attributes[:address][:street_address],
           address_type: recipient_attributes[:address][:address_type],
                    zip: recipient_attributes[:address][:zip]
    )
  end

  private

    def compute_total
      # self.total_charge = service.price + SALES_TAX
    end

    def add_to_customer_balance
      # current_user.balance += total_charge (change to order_total)
    end

end

# == Schema Information
#
# Table name: orders
#
#  id                    :integer          not null, primary key
#  order_total          :decimal(, )      default(0.0), not null
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

  attr_accessor :get_pickup_time, :pickup_time_request

  enum signature_requirement: { "No Signature" => 0, "Direct Signature" => 1, "Indirect Signature" => 2 }

  EARLIEST_ORDER_TIME  = Time.zone.parse("8:00am")
  LATEST_ORDER_TIME = Time.zone.parse("3:00pm")

  has_one :recipient, inverse_of: :order
  belongs_to :service, inverse_of: :orders
  has_one :shipper, inverse_of: :order

  # TODO: not sure about
  # belongs_to :user, inverse_of: :orders
  belongs_to :account, inverse_of: :orders


  validates :estimated_weight, presence: true
  validates :estimated_weight, numericality: { greater_than_or_equal_to: 1 }, if: "estimated_weight.present?"

  validates :number_of_items, presence: true
  validates :number_of_items, numericality: { greater_than_or_equal_to: 1 }, if: "number_of_items.present?"

  validates :service, presence: true

  validates :shipping_reference, length: { maximum: 50 },
                                 allow_blank: true

  validates :signature_requirement, presence: true,
                                    inclusion: { within: ["No Signature", "Indirect Signature", "Direct Signature"] }

  validates :special_instructions, length: { maximum: 2000 },
                                   allow_blank: true

  validates :order_total, presence: true,
                          numericality: { greater_than_or_equal_to: 0 }

  validates_associated :recipient

  validates_associated :shipper

  # NOTE: Custom validations
  validate :pickup_date_set_in_the_past
  validate :pickup_time_set_in_the_past
  validate :pickup_not_within_biz_hours
  validate :pickup_not_within_serv_hours


  def get_pickup_time=(pickup_time)
     self.pickup_time = "#{pickup_time[4]}:#{pickup_time[5]}"
     self.pickup_time << "0" if pickup_time[5] == 0
  end

  def shipper_attributes=(shipper_attributes)
    shipper = self.build_shipper(
      first_name: shipper_attributes[:first_name],
      last_name:  shipper_attributes[:last_name]
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
      last_name:  recipient_attributes[:last_name]
      )

    recipient.build_phone(
      phone_type:   recipient_attributes[:phone][:phone_type],
      phone_number: recipient_attributes[:phone][:phone_number],
      ext:          recipient_attributes[:phone][:ext]
      )

    recipient.build_address(
      address_type:      recipient_attributes[:address][:address_type],
      street_address:    recipient_attributes[:address][:street_address],
      secondary_address: recipient_attributes[:address][:secondary_address],
      zip:               recipient_attributes[:address][:zip]
      )
  end


  private

    def within_service_hours?
      # NOTE: Apply a 10 min padding to the pickup_time for users to complete the form to help prevent against validation errors for pickup times set to the current time.
      request_time  = Time.zone.parse(pickup_time) + 10.minutes
      service_open  = Time.zone.parse(service.start_time)
      service_end = Time.zone.parse(service.end_time)

      request_time.between?(service_open, service_end)
    end


    def within_biz_hours?
      @hours ||= Time.zone.parse(pickup_time).between?(EARLIEST_ORDER_TIME, LATEST_ORDER_TIME) ? true : false
    end

    def pickup_not_within_serv_hours
      if pickup_time.present? && within_biz_hours? && !within_service_hours?
        error_message = "#{service.service_name} can no longer be ordered at this time because it's past the #{Time.zone.parse(service.end_time).strftime('%I:%M %p')} cut off time. Please "

        if service.service_name != "ASAP"
          error_message += "select a different service or "
        end

        error_message += "choose a later pickup date."

        errors.add(:base, error_message)
      end
    end

    def pickup_not_within_biz_hours
      if pickup_time.present? && !within_biz_hours?
        errors.add(:base, "The pickup time you indicated is not within our service hours:  #{ EARLIEST_ORDER_TIME.strftime('%l:%M %p')} to #{LATEST_ORDER_TIME.strftime('%l:%M %p')}. Please select a valid time.")
      end
    end

    def pickup_time_set_in_the_past
      if pickup_date.present? && pickup_time.present? && pickup_date.today? && (Time.zone.parse(pickup_time) + 10.minutes).past?

        errors.add(:pickup_time, "cannot be set in the past. Please choose a valid pickup time.")
      end
    end

    def pickup_date_set_in_the_past
      if pickup_date.present? && pickup_date.past?
        errors.add(:pickup_date, "cannot be set for to past date. Please choose a valid date.")
      end
    end

end

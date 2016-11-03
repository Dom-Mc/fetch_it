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

  # TODO: Add to services table
  BIZ_START_TIME  = "08:00"
  BIZ_END_TIME = "16:00"
  TIME_REGEX = /\A(2[0-3]|[01]?[0-9]):([0-5]?[0-9])( )?([APap][mM])?\z/

# TODO: not sure about pickup_time_request
  attr_accessor :parsed_pickup_time

  enum signature_requirement: { "No Signature" => 0, "Direct Signature" => 1, "Indirect Signature" => 2 }

  before_validation :set_pickup_time, if: :pickup_time_valid?

  has_one :shipper, inverse_of: :order
  has_one :recipient, inverse_of: :order
  belongs_to :service, inverse_of: :orders
  belongs_to :account, inverse_of: :orders

  validates_associated :shipper

  validates_associated :recipient

  validates :pickup_date, presence: true

  validates :pickup_time, presence: true

  validates :service, presence: true

  validates :special_instructions, length: { maximum: 2000 },
                                   allow_blank: true

  validates :signature_requirement, presence: true,
                                    inclusion: { within: ["No Signature", "Indirect Signature", "Direct Signature"] }

  validates :estimated_weight, presence: true
  validates :estimated_weight, numericality: { greater_than_or_equal_to: 1 },
                               if: "estimated_weight.present?"

  validates :number_of_items, presence: true
  validates :number_of_items, numericality: { greater_than_or_equal_to: 1 },
                              if: "number_of_items.present?"

  validates :shipping_reference, length: { maximum: 50 },
                                 allow_blank: true

  # TODO: Add later
  # validates :order_total, presence: true, numericality: { greater_than_or_equal_to: 0 }

  default_scope { order(id: :desc) }

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

  # NOTE: Custom validations
  validate :pickup_time_format_is_valid, unless: "pickup_time.blank?"
  validate :pickup_date_not_in_the_past,
           :pickup_time_not_in_the_past,
           :pickup_within_biz_hours,
           :pickup_within_serv_hours,
              if: :pickup_date_and_time_are_present?

  private

    def set_pickup_time
      self.pickup_time = Time.zone.parse(parsed_pickup_time).strftime('%H:%M')
    end

    def pickup_time_valid?
      self.parsed_pickup_time = pickup_time.gsub(/\s+/, '').downcase
      @pickup_time_valid = parsed_pickup_time.match(TIME_REGEX).present? &&
                           pickup_time.present?
    end

    def pickup_time_format_is_valid
      if !pickup_time_valid?
        errors.add(:pickup_time, "invalid, not in the correct format (example: 11:00AM).")
      end
    end

    def pickup_date_and_time_are_present?
      @pickup_date_and_time_are_present = pickup_time.present? &&
                                          pickup_date.present? &&
                                          pickup_time_valid?
    end

    def within_service_hours?
      @within_service_hours ||= pickup_time.between?(service.start_time, service.end_time)
    end

    def within_biz_hours?
      @within_biz_hours ||= pickup_time.between?(BIZ_START_TIME, BIZ_END_TIME)
    end

    def pickup_within_biz_hours
      if !within_biz_hours?
        start_time = Time.zone.parse(BIZ_START_TIME).strftime('%-l:%M%p').squish
        end_time   = Time.zone.parse(BIZ_END_TIME).strftime('%-l:%M%p').squish

        errors.add(:base, "The pickup time you indicated is not within our service hours:  #{start_time} to #{end_time}. Please select a valid time.")
      end
    end

    def pickup_within_serv_hours
      if within_biz_hours? && !within_service_hours?
        start_time = Time.zone.parse(service.start_time).strftime('%-l:%M%p')
        end_time = Time.zone.parse(service.end_time).strftime('%-l:%M%p')

        errors.add(:base, "#{service.service_name} - service pickups are available from #{start_time} to #{end_time}. For questions regarding service availability, please visit our Services page for more information.")
      end
    end

    def pickup_time_not_in_the_past
      # NOTE: Apply a 15 min padding to the pickup_time for users to complete the form to help prevent against validation errors for pickup times set to the current time.
      if pickup_date.today? && (Time.zone.parse(pickup_time) + 15.minutes).past?
        errors.add(:pickup_time, "cannot be set in the past. Please choose a valid time.")
      end
    end

    def pickup_date_not_in_the_past
      if pickup_date.past?
        errors.add(:pickup_date, "cannot be set in the past. Please choose a valid date.")
      end
    end



    # TODO: Add charges to Order

    # NOTE: List of Charges
    # RESIDENTIAL_CHARGE = 1.5
    # SUNDAY_CHARGE      = 30
    # SATURDAY_CHARGE    = 15
    # LATE_CHARGE        = 40
    # PER_LB_CHARGE      = 2.5
    # SALES_TAX          = 0.0875
    # # service.price (included)
    # self.list_of_charges    = [RESIDENTIAL_CHARGE, PER_LB_CHARGE]
    #
    # START_OF_DAY = 8 # 8:00am (Pacific Standard Time)
    # END_OF_DAY   = 15 # 3:00pm (Pacific Standard Time)
    #
    # AVAILABILITY_8HOUR_SER   = [8, 9] (9am cutoff)
    # AVAILABILITY_4HOUR_SER   = [8, 11] (11pm cutoff)
    # AVAILABILITY_EXPRESS_SER = [8, 1] (1pm)
    # AVAILABILITY_ASAP_SER    = [8, 3]
    # order.pickup_time.hour.between?(8, 15)
    #
    #
    # def list_of_charges
    #   LIST_OF_CHARGES << LATE_CHARGE if delivery_time < # "random_time" TODO
    #   if pickup_date.saturday?
    #     LIST_OF_CHARGES << SATURDAY_CHARGE
    #   elsif order.pickup_date.sunday?
    #     LIST_OF_CHARGES << SUNDAY_CHARGE
    #   else
    #     LIST_OF_CHARGES
    #   end
    # end
    #
    # def additional_charges
    #   LIST_OF_CHARGES.inject(service.price) { |sum, amount| sum + amount }
    # end
    #
    # def tax_charge
    #   additional_charges * SALES_TAX
    # end
    #
    # def total_charge
    #   tax_charge + additional_charges
    # end
    #
    # def calculate_balance
    #   self.order_total = total_charge
    #   # TODO: Add #balance to users
    #   # self.user.balance += order_total
    #   save
    # end

end

module OrdersHelper

  # Set Shipper, Shipper Address, Shipper Phone, Recipient, Recipient Address, Recipient Phone
  def set_shipper
    @set_shipper = @order.shipper || @order.build_shipper
  end

  def set_shipper_address
    set_shipper.address ||= set_shipper.build_address
    # @order.shipper.address || @order.shipper.build_address
  end

  def set_shipper_phone
    set_shipper.phone ||= set_shipper.build_phone
    # @order.shipper.phone || @order.shipper.build_phone
  end

  def set_recipient
    @set_recipient = @order.recipient || @order.build_recipient
  end

  def set_recipient_address
    set_recipient.address || set_recipient.build_address
    # @order.recipient.address || @order.recipient.build_address
  end

  def set_recipient_phone
    set_recipient.phone || set_recipient.build_phone
    # @order.recipient.phone || @order.recipient.build_phone
  end

  # Addresses (Shipper & Recipient)
  def address_type_collection
    @address_type_collection = Address.address_types.keys.to_a
  end

  def first_address_type
    @first_address_type = address_type_collection.first
  end

  def shipper_address_type_selected
    if @order.shipper.address&.address_type.present?
      @order.shipper.address.address_type
    else
      first_address_type
    end
  end

  def recipient_address_type_selected
    if @order.recipient.address&.address_type.present?
      @order.recipient.address.address_type
    else
      first_address_type
    end
  end


  # Phones (Shipper & Recipient)
  def phone_type_collection
    @phone_type_collection = Phone.phone_types.keys.to_a
  end

  def first_phone_type
    @first_phone_type = phone_type_collection.first
  end

  def shipper_phone_type_selected
    if @order.shipper.phone&.phone_type.present?
      @order.shipper.phone.phone_type
    else
      first_phone_type
    end
  end

  def recipient_phone_type_selected
    if @order.recipient.phone&.phone_type.present?
      @order.recipient.phone.phone_type
    else
      first_phone_type
    end
  end

  def phone_type_selected
    # NOTE: set to "Mobile" by default
    @phone_type_selected = phone_type_collection.first
  end


  # Pickup Dates & Times
  def past_cuttoff_time?
    # TODO: change to set endtime variable
    Date.current.today? && Time.current.hour > 15 ? true : false
  end

  def set_date
    past_cuttoff_time? ? Date.tomorrow : Date.current
  end

  def pickup_date_selected
    @order.pickup_date || set_date
  end

  def set_time
    # TODO: change times to variables
    if Time.current.hour < 9 || Time.current.hour > 15
      Time.zone.parse("9:00")
    else
      1.hour.from_now
    end
  end

  def pickup_time_selected
    @order.pickup_time ||= set_time
    Time.zone.parse(@order.pickup_time)
  end


  # Service
  def service_type_collection
    Service.all
  end

  def service_selected
    if @order.service.present?
      @order.service.service_name
    else
      Service.first.service_name
    end
  end

  # Signature
  def signature_requirement_collection
    Order.signature_requirements.to_a
  end

  def signature_requirement_selected
    if @order.signature_requirement.present?
      @order.signature_requirement
    else
      signature_requirement_collection.first
    end
  end

end

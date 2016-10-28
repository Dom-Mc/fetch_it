module OrdersHelper

  def past_cuttoff_time?
    # TODO: change to set endtime variable
    Date.current.today? && Time.current.hour > 15 ? true : false
  end

  def set_date
    if past_cuttoff_time?
      Date.tomorrow
    else
      Date.current
    end
  end

  def set_time
    if Time.current.hour < 9 || Time.current.hour > 15
      Time.zone.parse("9:00")
    else
      1.hour.from_now
    end
  end

  def display_date
    @order.pickup_date ||= set_date
  end

  def display_time
    @order.pickup_time ||= set_time
    Time.zone.parse(@order.pickup_time)
  end

  def display_service
    if @order.service.present?
      @order.service.service_name
    else
      Service.first.service_name
    end
  end
end

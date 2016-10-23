class OrdersController < ApplicationController
  before_action :authenticate_user!

    def index
    end

  def new
    # TODO: go over
    user = User.last
    @order = user.orders.build
    @shipper = @order.build_shipper
    @recipient = @order.build_recipient

  end

  def create
    binding.pry

    User.last.orders.create(order_params)
    binding.pry
    raise order_params.inspect
  end

  private

    def order_params
      params.require(:order).permit(
        :number_of_items,
        :order_total,
        :special_instructions,
        :shipping_reference,
        :estimated_weight,
        :service_id,
        shipper_attributes: [:first_name, :last_name, address: [:address_type, :street_address, :second_address, :zip], phone: [:phone_number, :phone_type, :ext]],
        recipient_attributes: [:first_name, :last_name, address: [:address_type, :street_address, :second_address, :zip], phone: [:phone_number, :phone_type, :ext]]
      )
    end

end

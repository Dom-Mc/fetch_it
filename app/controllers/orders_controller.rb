class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    binding.pry
    # TODO: call this page order history
    # @user = current_user
    @user_account = Account.friendly.find(params[:account_id])
    @order = @user_account.orders
  end

  def new
    @user_account = Account.friendly.find(params[:account_id])
    @order = @user_account.orders.build
    @shipper = @order.build_shipper
    @recipient = @order.build_recipient

    # @order = current_user.orders.build
    # @shipper = @order.build_shipper
    # @recipient = @order.build_recipient
  end

  def create
    @user_account = Account.friendly.find(params[:account_id])
    @order = @user_account.orders.build(order_params)
    # @order = current_user.orders.build(order_params)

    if @order.save
      redirect_to account_order_path(@user_account, @order), notice: 'Your order has been placed.'
      # redirect_to @order, notice: 'Your order has been placed.'
    else
      render :new
    end
  end

  def show
    @user_account = Account.friendly.find(params[:account_id])
    @order = @user_account.orders.find_by(params[:id])
    # @order = current_user.orders.find_by(params[:id])
  end

  private
    def order_params
      params.require(:order).permit(
        :pickup_date,
        :get_pickup_time,
        :number_of_items,
        :order_total,
        :special_instructions,
        :shipping_reference,
        :estimated_weight,
        :service_id,
        shipper_attributes: [:first_name, :last_name, address: [:address_type, :street_address, :secondary_address, :zip], phone: [:phone_number, :phone_type, :ext]],
        recipient_attributes: [:first_name, :last_name, address: [:address_type, :street_address, :secondary_address, :zip], phone: [:phone_number, :phone_type, :ext]]
      )
    end

end

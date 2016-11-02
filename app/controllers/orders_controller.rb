class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account_orders, only: [:index, :new, :create, :show]

  def index
    # TODO: call this page order history
    @orders = policy_scope(Order.all)
    # NOTE: fix
    # authorize @orders
  end

  def new
    @order = @orders.build
    authorize @order
  end

  def create
    @order = @orders.build(order_params)
    authorize @order
    if @order.save
      redirect_to account_order_path(@order.account, @order), notice: 'Your order has been placed. Thank you for using FetchIt!'
    else
      render :new
    end
  end

  def show
    @order = @orders.find(params[:id])
    authorize @order
  end

  private
    def set_account_orders
      @orders = Account.friendly.find(params[:account_id]).orders
    end

    def order_params
      params.require(:order).permit(
        :pickup_date,
        :pickup_time,
        :number_of_items,
        :order_total,
        :special_instructions,
        :shipping_reference,
        :estimated_weight,
        :service_id,
        shipper_attributes: [
          :first_name,
          :last_name,
          address: [
            :address_type,
            :street_address,
            :secondary_address,
            :zip
          ],
          phone: [
            :phone_number,
            :phone_type,
            :ext
          ]
        ],
        recipient_attributes:[
          :first_name,
          :last_name,
          address: [
            :address_type,
            :street_address,
            :secondary_address,
            :zip
          ],
          phone:[
            :phone_number,
            :phone_type,
            :ext]
          ]
      )
    end

end

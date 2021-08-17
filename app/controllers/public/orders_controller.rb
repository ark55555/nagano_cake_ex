class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @order.customer_id = current_customer.id
    # @deliveries = current_customer.deliveries
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == '0'
      @order.delivery_address = current_customer.address
      @order.postcode = current_customer.postcode
      @order.delivery_name = current_customer.full_name
    elsif params[:order][:select_address] == '1'

      @selected_address =  current_customer.deliveries.find(params[:order][:delivery_id])
      @order.delivery_address = @selected_address.destination
      @order.postcode = @selected_address.postcode
      @order.delivery_name = @selected_address.name
    elsif params[:order][:select_address] == '2'
      @order.delivery_address = params[:order][:delivery_address]
      @order.postcodepostal_code = params[:order][:delivery_postcode]
      @order.delivery_name = params[:order][:delivery_name]
    else
      flash[:error] = '情報を正しく入力して下さい。'
      render :new
    end

  end

  def create
  end

  def thanks
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:delivery_name, :delivery_postcode, :delivery_address, :payment_method)
  end

end

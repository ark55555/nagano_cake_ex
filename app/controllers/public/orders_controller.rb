class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_cart_items, only: [:new, :confirm, :create]

  def new
    @order = Order.new
    @order.customer_id = current_customer.id
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == '0'
      @order.delivery_address = current_customer.address
      @order.delivery_postcode = current_customer.postcode
      @order.delivery_name = current_customer.full_name
    elsif params[:order][:select_address] == '1'
      @selected_address =  current_customer.deliveries.find(params[:order][:delivery_id])
      @order.delivery_address = @selected_address.destination
      @order.delivery_postcode = @selected_address.postcode
      @order.delivery_name = @selected_address.name
    elsif params[:order][:select_address] == '2'
      @order.delivery_address = params[:order][:delivery_address]
      @order.delivery_postcode = params[:order][:delivery_postcode]
      @order.delivery_name = params[:order][:delivery_name]
    else
      flash[:error] = '情報を正しく入力して下さい。'
      render :new
    end
    @cart_items = current_customer.cart_items.all
    @order.shipping_cost = 800

  end
  
  def error
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.shipping_cost = 800
    @cart_items = current_customer.cart_items.all
    @order.total_price = @order.shipping_cost + @cart_items.sum(&:subtotal)
    if @order.save
      @cart_items.each do |cart_item|
        @order_item = @order.order_items.new
        @order_item.item_id = cart_item.item_id
        @order_item.amount = cart_item.amount
        @order_item.price = cart_item.item.add_tax_price
        @order_item.save
      end
      current_customer.cart_items.destroy_all
      redirect_to thanks_path
    else
      render :new
    end
  end

  def thanks
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:delivery_name, :delivery_postcode, :delivery_address, :payment_method)
  end

  def ensure_cart_items
    @cart_items = current_customer.cart_items.includes(:item)
    if @cart_items.empty?
      redirect_to items_path, flash: {danger: 'カートに商品を入れてください'}
    end
  end

end

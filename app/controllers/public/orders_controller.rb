class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_cart_items, only: [:new, :confirm, :create]

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == '0'
      @order.get_shipping_info(current_customer)
    elsif params[:order][:select_address] == '1'
      @selected_address = current_customer.deliveries.find(params[:order][:delivery_id])
      @order.get_shipping_info(@selected_address)
    elsif params[:order][:select_address] == '2' && @order.delivery_address? && (@order.delivery_postcode =~ /\A\d{7}\z/) && @order.delivery_name?
      @order.delivery_address = params[:order][:delivery_address]
      @order.delivery_postcode = params[:order][:delivery_postcode]
      @order.delivery_name = params[:order][:delivery_name]
    else
      flash[:warning] = '情報を正しく入力して下さい。'
      redirect_to new_order_path
    end
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
      redirect_to thanks_path, flash: {info: '注文を承りました！'}
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

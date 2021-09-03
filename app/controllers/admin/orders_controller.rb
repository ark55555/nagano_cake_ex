class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @customer = @order.customer
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      @order.change_making_status
      redirect_to admin_order_path(@order), flash: {success: "注文ステータスを更新しました！"}
    else
      render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end

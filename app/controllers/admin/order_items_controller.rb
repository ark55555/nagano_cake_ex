class Admin::OrderItemsController < ApplicationController

  def update
    @order_item = OrderItem.find(params[:id])
    if @order_item.update(order_item_params)
      @order_item.change_order_status
      redirect_to admin_order_path(@order_item.order), flash: {success: "製作ステータスを更新しました！"}
    else
      render :show
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:making_status)
  end
end
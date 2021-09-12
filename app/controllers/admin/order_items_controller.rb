class Admin::OrderItemsController < ApplicationController

  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    if @order.status != "入金待ち"
      @order_item.update(order_item_params)
      @order_item.change_order_status
      redirect_to admin_order_path(@order), flash: {success: "製作ステータスを更新しました！"}
    else
      flash[:warning] = "注文ステータスが「入金待ち」の為、変更できません"
      redirect_to admin_order_path(@order)
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:making_status)
  end
end
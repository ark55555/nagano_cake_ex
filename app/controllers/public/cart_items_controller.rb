class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart_item, only: [:create, :update, :destroy]

  def index
    @cart_items = current_customer.cart_items.all
  end

  def create
    if @cart_item
      new_amount = @cart_item.amount + cart_item_params[:amount]
      @cart_item.update(amount: new_amount)
      redirect_to cart_items_path
    else
      @cart_item = current_customer.cart_items.new(cart_item_params)
      @cart_item.item_id = @item.id
      if @cart_item.save
        redirect_to cart_items_path, notice: 'カートに商品が追加されました'
      else
        render 'public/items/show'
      end
    end
  end

  def update
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path, notice: '商品数量変更完了しました'
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_items_path, notice: '削除しました'
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path, notice: 'カート内商品を全て削除しました'
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount)
  end

  def set_cart_item
    @item = Item.find(params[:item_id])
    @cart_item = current_customer.has_in_cart(@item)
  end

end

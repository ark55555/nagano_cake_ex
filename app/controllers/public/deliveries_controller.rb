class Public::DeliveriesController < ApplicationController
  before_action :set_delivery, only: [:edit, :update, :destroy]

  def index
    @delivery = Delivery.new
    @deliveries = current_customer.deliveries
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id = current_customer.id
    if @delivery.save
      redirect_to deliveries_path, notice: '配送先を登録しました'
    else
      @deliveries = current_customer.deliveries
      render :index
    end
  end

  def edit
  end

  def update
    if @delivery.update(delivery_params)
      redirect_to deliveries_path, notice: '配送先情報を変更しました'
    else
      render :edit
    end
  end

  def destroy
    @delivery.destroy
    redirect_to deliveries_path, notice: '配送先を削除しました'
  end

  private

  def delivery_params
    params.require(:delivery).permit(:name, :destination, :postcode)
  end
  
  def set_delivery
    @delivery = Delivery.find(params[:id])
  end

end

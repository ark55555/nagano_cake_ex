class Public::DeliveriesController < ApplicationController
  
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
  end
  
  def destroy
  end
  
  private
  
  def delivery_params
    params.require(:delivery).permit(:name, :destination, :postcode)
  end
  
end

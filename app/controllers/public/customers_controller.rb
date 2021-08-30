class Public::CustomersController < ApplicationController
  before_action :set_current_customer

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to mypage_path, notice: '会員情報を更新しました'
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
  end
  
  private
  
  def set_current_customer
    @customer = current_customer
  end
  
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postcode, :address, :phone_number)
  end
end

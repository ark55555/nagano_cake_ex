class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_items, dependent: :destroy

 validates :total_price, presence: true, numericality: {greater_than_or_equal_to: 0 }
 validates :shipping_cost, presence: true, numericality: {greater_than_or_equal_to: 0 }
 validates :delivery_address, presence: true
 validates :delivery_postcode, presence: true, format: { with: /\A\d{7}\z/ }
 validates :delivery_name, presence: true
 
 enum payment_method: { クレジットカード: 0, 銀行振込: 1 }
 enum status: { 入金待ち: 0, 入金確認: 1, 制作中: 2, 発送準備中: 3, 発送済: 4 }
 
 
 
end

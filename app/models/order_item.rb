class OrderItem < ApplicationRecord

  belongs_to :item
  belongs_to :order

  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0 }
  validates :amount, presence: true, numericality: {greater_than_or_equal_to: 1 }

  enum making_status: { 着手不可: 0, 製作待ち: 1, 制作中: 2, 製作完了: 3 }

  def subtotal
    price * amount
  end

 def change_order_status
   if self.making_status == "制作中"
     self.order.update(status: 2)
   elsif self.making_status == "製作完了"
     self.order.update(status: 3)
   end
 end

end

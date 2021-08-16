class Delivery < ApplicationRecord
  
  belongs_to :customer
  
  validates :postcode, presence: true, format: { with: /\A\d{7}\z/ }
  validates :destination, presence: true
  validates :name, presence: true
  
  def full_address
    '〒' + postcode + ' ' + destination + ' ' + name
  end
  
end

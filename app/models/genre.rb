class Genre < ApplicationRecord
  
  has_many :items
  
  validates :name, presence :ture, uniqueness: true

end

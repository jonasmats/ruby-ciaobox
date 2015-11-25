class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :shipping
  has_many :order_details

end
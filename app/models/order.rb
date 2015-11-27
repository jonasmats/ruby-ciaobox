class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :shipping
  has_many :order_details
  has_one :feedback
  accepts_nested_attributes_for :order_details
end
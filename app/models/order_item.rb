class OrderItem < ActiveRecord::Base
  translates :title, :description, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations
  has_one :order_detail
  has_many :order_detail_images
end
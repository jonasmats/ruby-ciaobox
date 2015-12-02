class OrderDetail < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :order
  belongs_to :order_item

  validates :order_item, :price, :quantity, :barcode, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  before_validation :set_price
  before_validation :set_barcode

  private
  def set_price
    self.price = self.quantity * self.order_item.price
  end

  def set_barcode
    self.barcode = Time.current
  end
end

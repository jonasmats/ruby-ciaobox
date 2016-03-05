class OrderDetail < ActiveRecord::Base
  acts_as_paranoid
  enum status: {
    delivery_scheduled: 0,
    delivered: 1
  }

  belongs_to :order
  belongs_to :order_item

  validates :order_item, :price, :quantity, :barcode, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates_format_of :delivery_time, with: /\A^[0-9][a-zA-Z0-9-.\s]*$\z/, message: 'must be valid', :if => :not_empty_delivery_time?

  before_validation :set_price
  before_validation :set_barcode
  #before_validation :set_delivery_time

  scope :stored, -> {
    where('status NOT IN (?) OR status IS NULL', [statuses[:delivery_scheduled], statuses[:delivered]])
  }
  scope :in_transit, -> {
    where(status: statuses[:delivery_scheduled])
  }

  private
  def set_price
    self.price = self.quantity * self.order_item.price
  end

  def set_barcode
    self.barcode = Time.current
  end

  def set_delivery_time
    self.delivery_time = '00 - 00'
  end

  def not_empty_delivery_time?
    self.delivery_time.present?
  end
end

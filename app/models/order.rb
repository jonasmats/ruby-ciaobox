class Order < ActiveRecord::Base
  acts_as_paranoid
  enum status: {registering: 0, checking: 1, reject: 2, processing: 3, holding: 4, cancel: 5, returned: 6}

  # 1. association
  belongs_to :user
  belongs_to :shipping
  has_many :order_details, dependent: :destroy
  has_one :feedback, dependent: :destroy
  accepts_nested_attributes_for :order_details
  accepts_nested_attributes_for :feedback

  # 2. scope
  scope :registering, -> { where(status: statuses[:registering]) }
  # 4. validation
  validates :user, :shipping, :pay_status,
    :shipping_date, :shipping_time,
    :address, :state,
    presence: true

  # 2. scope
  scope :registering, -> { where(status: statuses[:registering]) }
  #5. callbacks
  # 5. callbacks
  # before_create :init_score
  after_create :set_amount

  #6. instance methods
  # def any_instance_method
  # end
  private
  def set_amount
    self.update(amount: self.order_details.sum(:price))
  end
end
  delegate :full_name, to: :user, prefix: true
end

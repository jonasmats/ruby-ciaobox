class Order < ActiveRecord::Base
  acts_as_paranoid
  enum status: {registering: 0,
   amount_confirm: 1, checking: 2, reject: 3, processing: 4, holding: 5,
   cancel: 6, returned: 7}

  # 1. association
  belongs_to :user
  belongs_to :shipping
  has_many :order_details, dependent: :destroy
  has_many :order_items, through: :order_details
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

  validates :contact_name,:contact_email, :contact_phone, 
    presence: true, if: :validate_step_2?
  #5. callbacks
  # 5. callbacks
  # before_create :init_score
  after_save :set_amount, if: :set_amount?

  #6. instance methods
  delegate :full_name, to: :user, prefix: true
  # def any_instance_method
  # end
  private
  def set_amount
    self.update!(
      status: Order.statuses[:checking],
      amount: self.order_details.sum(:price)
    )
  end

  def set_amount?
    self.amount_confirm?
  end

  def validate_step_2?
    self.persisted? && self.order_details.first.present? && self.order_details.first.persisted?
  end
end

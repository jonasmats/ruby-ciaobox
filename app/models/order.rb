class Order < ActiveRecord::Base
  acts_as_paranoid
  enum status: {
    registering: 0,
    amount_confirm: 1,
    checking: 2,
    reject: 3,
    dropoff: 4,
    pickup_scheduled: 5,
    stored: 6,
    holding: 7,
    cancel: 8,
    returned: 9
  }

  # 1. association
  belongs_to :user, class_name: User.name, foreign_key: :user_id
  belongs_to :shipping
  has_many :order_details, dependent: :destroy
  has_many :order_items, through: :order_details
  has_one :feedback, dependent: :destroy
  has_one :payment_subscription, :class_name => 'Payment::Subscription', dependent: :destroy
  accepts_nested_attributes_for :order_details
  accepts_nested_attributes_for :feedback

  # 2. scope
  scope :registering, -> { where(status: statuses[:registering]) }
  scope :upcoming, -> {
    includes(:order_details).
    #where(:status => [statuses[:checking]]).
    where(status: statuses[:checking]).
    where("to_date(shipping_date, 'MM/DD/YYYY') >= current_date").
    order("to_date(shipping_date, 'MM/DD/YYYY')")
    #limit(1)
  }
  scope :dropoff, -> {
    includes(:order_details).
    where(status: statuses[:dropoff])
  }
  scope :pickup_scheduled, -> {
    includes(:order_details).
    where(status: statuses[:pickup_scheduled]).
    where("to_date(shipping_date, 'MM/DD/YYYY') >= current_date").
    order("to_date(shipping_date, 'MM/DD/YYYY')")
  }
  scope :stored, -> {
    includes(:order_details).
    where(status: statuses[:stored])
  }
  scope :allitems, -> {
    includes(:order_details).
    where(:status => [statuses[:checking], statuses[:dropoff], statuses[:pickup_scheduled], statuses[:stored]])
  }
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

  public def check_amount?
    total_amount = self.order_details.sum(:price);
    if total_amount >= 25
      return true;
    else
      return false;
    end
  end

  def validate_step_2?
    self.persisted? && self.order_details.first.present? && self.order_details.first.persisted?
  end

  public
  def self.months_to_case
    ['January', 'Febraury', 'March', 'April', 'May', 'June', 'July', 'Auguest', 'September', 'October', 'November','December']
  end

end

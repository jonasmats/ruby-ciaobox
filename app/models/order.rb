class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :shipping
  has_many :order_details, dependent: :destroy
  has_one :feedback, dependent: :destroy
  accepts_nested_attributes_for :order_details
  
  enum status: {registering: 0, checking: 1, reject: 2, processing: 3, holding: 4, cancel: 5, returned: 6}

  validates :user, :shipping, :pay_status, :shipping_date, :shipping_time, presence: true
  # 2. scope
  scope :registering, -> { where(status: statuses[:registering]) }
  #5. callbacks
  # before_create :init_score

  #6. instance methods
  # def any_instance_method
  # end
end
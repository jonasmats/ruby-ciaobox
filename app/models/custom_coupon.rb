class CustomCoupon < Coupon
  # 1. associations

  # 2. scopes

  # 3. class methods

  # 4. validates
  validates :start_date, :end_date, :discount_type, :discount_value, presence: true
  # 5. callbacks

  # 6. instance methods
end

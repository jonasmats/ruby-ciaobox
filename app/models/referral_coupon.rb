class ReferralCoupon < Coupon
  # 1. associations

  # 2. scopes

  # 3. class methods

  # 4. validates
  validates :discount_type, :discount_value, presence: true
  # 5. callbacks

  # 6. instance methods
end

class CouponStandardHistory < CouponHistory
  # 1. associations
  belongs_to :coupon, class_name: Coupon.name, foreign_key: :coupon_id

  # 2. scopes

  # 3. class methods

  # 4. validates

  # 5. callbacks

  # 6. instance methods
end

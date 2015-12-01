class CustomGift < Coupon
  # 1. associations
  has_many :gifts_coupons
  has_many :gifts, through: :gifts_coupons
  accepts_nested_attributes_for :gifts_coupons, allow_destroy: true, reject_if: :all_blank
  # 2. scopes

  # 3. class methods

  # 4. validates
  validate :valid_gift
  # 5. callbacks

  # 6. instance methods
  def valid_gift
    if self.gifts_coupons.blank? || gifts_coupons.first.gift_id.blank? || gifts_coupons.first.amount.blank?
      errors.add(:gift, I18n.t("errors.messages.not_blank"))
    end 
  end
end

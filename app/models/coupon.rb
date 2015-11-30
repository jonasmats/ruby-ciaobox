class Coupon < ActiveRecord::Base
  translates :name, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations
  enum discount_type: {price: 0, percent: 1}
  # 1. associations
  has_many :coupon_standard_histories, class_name: CouponStandardHistory.name, 
    foreign_key: :coupon_id 

  # 2. scopes

  # 3. class methods

  # 4. validates
  validates :code, presence: true
  # 5. callbacks

  # 6. instance methods
end

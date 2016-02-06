class Dashboard::HomeController < Dashboard::BaseDashboardController

  before_action :check_and_create_coupon

  def index
    #@user = User.includes(:orders, :order_items, :notification).find(current_user.id)
    #logger.debug("USER-ORDER:: #{current_user.orders.upcoming[0].order_details.inspect}")
  end

  private
  def check_and_create_coupon
    if current_user.coupon_code.blank?
      coupon_code = generate_coupon_code
      User.update(current_user.id, :coupon_code => coupon_code)

      @coupon = ReferralCoupon.new
      @coupon.code = coupon_code
      @coupon.discount_type = 0
      @coupon.discount_value = '28.5'
      @coupon.save!
    else
      @coupon = ReferralCoupon.find_by_code(current_user.coupon_code)
    end
  end

  def generate_coupon_code
    result = ''
    length = 4
    chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    for i in (length).downto(1)
      result = result + chars[(rand() * (chars.mb_chars.length - 1)).round]
    end

    return result
  end
end

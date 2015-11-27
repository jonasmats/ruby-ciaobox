module Admin::Coupons::Finder
  extend ActiveSupport::Concern
  def load_coupons
    Coupon.all.includes(:translations)
  end

  def load_instance
    @coupon = Coupon.find(params[:id])
  end
end
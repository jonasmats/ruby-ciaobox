class Dashboard::HomeController < Dashboard::BaseDashboardController

  before_action :check_and_create_coupon

  def index
    #@user = User.includes(:orders, :order_items, :notification).find(current_user.id)
    #logger.debug("USER-ORDER:: #{current_user.orders.upcoming[0].order_details.inspect}")
    @count_items_in_storage = 0
    @items_in_storage = []

    current_user.orders.allitems.each do |item|
      @items_in_storage = @items_in_storage + item.order_details
      @count_items_in_storage = @count_items_in_storage + item.order_details.count
    end

    current_user.orders.upcoming[0].order_details.select("order_item_id, count(quantity) as qty").group("order_item_id").order("order_item_id").each do |item|
      if item.order_item[:type] == OrderItem::Bin.name
        suffix = (item.qty <= 1) ? " Ciaobox Bin" : " Ciaobox Bins"
        @sub_notify_title = item.qty.to_s + suffix
      end
      if item.order_item[:type] == OrderItem::Box.name
        comma = ", " if @sub_notify_title.present?
        suffix = (item.qty <= 1) ? " Box" : " Boxes"
        @sub_notify_title = @sub_notify_title + comma + item.qty.to_s + suffix
      end
      if item.order_item[:type] == OrderItem::Normal.name
        comma = ", " if @sub_notify_title.present?
        suffix = (item.qty <= 1) ? " Normal Unit" : " Normal Units"
        @sub_notify_title = @sub_notify_title + comma + item.qty.to_s + suffix
      end
      if item.order_item[:type] == OrderItem::Other.name
        comma = ", " if @sub_notify_title.present?
        suffix = (item.qty <= 1) ? " Other" : " Others"
        @sub_notify_title = @sub_notify_title + comma + item.qty.to_s + suffix
      end
    end

    logger.debug("ITEMS IN STORAGE:: #{@sub_notify_title}")
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

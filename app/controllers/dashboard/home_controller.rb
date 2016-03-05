class Dashboard::HomeController < Dashboard::BaseDashboardController

  before_action :check_and_create_coupon

  def index
    #@user = User.includes(:orders, :order_items, :notification).find(current_user.id)
    #logger.debug("USER-ORDER:: #{current_user.orders.upcoming[0].order_details.inspect}")
    @count_items_in_storage = 0
    @count_items_available_in_storage = 0
    @count_items_available_to_delivery = 0
    @items_in_storage = []

    current_user.orders.allitems.each do |item|
      @items_in_storage = @items_in_storage + item.order_details.includes(:order)
      @count_items_in_storage = @count_items_in_storage + item.order_details.count
      if [Order.statuses[:dropoff], Order.statuses[:pickup_scheduled], Order.statuses[:stored]].include?(item[:status])
        @count_items_available_in_storage = @count_items_available_in_storage + item.order_details.count
      end

      if item[:status] == Order.statuses[:stored]
        @count_items_available_to_delivery = @count_items_available_to_delivery + item.order_details.count
      end
    end

    logger.debug("ITEMS IN STORAGE:: #{@items_in_storage}, COUNT:: #{@count_items_available_in_storage}")

    # Order Detail Image Management
    img_dir_path = Settings.detrack.photo_dir_path

    @item_photos = Hash.new
    logger.debug("ITEMS IN STORAGE:: #{@items_in_storage.inspect}\n")
    @items_in_storage.each do |item|
      @item_photos[item[:id]] = []

      img_path = img_dir_path + item[:barcode] + '.jpg'
      if File.exist?(img_path)
        logger.debug("IMAGE PATH1:: #{img_path.inspect}\n")
        @item_photos[item[:id]] << Settings.detrack.photo_uri_path + item[:barcode] + '.jpg'
      else
        (0..9).each do |inx|
          img_path = img_dir_path + item[:barcode] + '_' + inx.to_s + '.jpg'
          #img_path = img_dir_path + inx.to_s + '.jpg'
          if File.exist?(img_path)
            @item_photos[item[:id]] << Settings.detrack.photo_uri_path + item[:barcode] + '_' + inx.to_s + '.jpg'
            #@item_photos[item[:id]] << Settings.detrack.photo_uri_path + inx.to_s + '.jpg'
            logger.debug("IMAGE PATH2:: #{img_path.inspect} => #{item[:id]}\n")
          end
        end
      end
    end

    if current_user.orders.upcoming.blank?
      return
    end

    @sub_notify_title = ''
    comma = ''
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

    #logger.debug("ITEMS IN STORAGE:: #{@sub_notify_title}")
  end

  def update
    if params[:id] == "dropoff"
      Order.where("id = ?", params[:order_id]).update_all(status: Order.statuses[:dropoff])
      redirect_to dashboard_root_path
    end

    if params[:id] == "cancel"
      #Remove From Detrack
      one_order = Order.find(params[:order_id])
      order_no = 'DRP-' + one_order[:id].to_s
      delivery_date = Date.strptime(one_order[:shipping_date], "%m/%d/%Y")
      delivery_date = delivery_date.strftime("%Y-%m-%d")
      logger.debug("HOME_CONTROLLER:: #{order_no}, #{delivery_date}")
      ::Shipping::Detrack.delete_delivery(delivery_date, order_no)

      #Update Order table
      Order.where("id = ?", params[:order_id]).update_all(status: Order.statuses[:cancel])

      redirect_to dashboard_root_path
    end
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

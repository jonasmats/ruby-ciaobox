class Dashboard::MystuffController < Dashboard::BaseDashboardController

  def index
    @count_items_in_storage = 0
    @items_in_storage = []

    current_user.orders.allitems.each do |item|
      @items_in_storage = @items_in_storage + item.order_details.includes(:order)
      @count_items_in_storage = @count_items_in_storage + item.order_details.count
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
  end
end
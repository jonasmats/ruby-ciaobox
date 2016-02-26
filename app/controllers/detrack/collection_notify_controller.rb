class CollectionNotifyController < ActionController::Base
  def create

    # Filtering params from Push Notification Post
    collection_date = params[:date]
    collection_date = Date.strptime(collection_date, "%Y-%m-%d")
    collection_date = collection_date.strftime("%m/%d/%Y")

    collection_time = params[:collection_time]
    order_no = params[:do]
    status = params[:status]
    items = params[:items]

    items.each do |item|
      po_no = item["po_no"] # order detail id
      sno = item["sno"] # barcode

      if po_no.present? && sno.present?
        # Update DB
        OrderDetail.where('id = ?', po_no).update(barcode: sno)
      end
    end

    order_id = order_no.to_i
    case status
      when "Collected"
        Order.where('id = ?', order_id).update(status: Order.statuses[:stored], shipping_date: collection_date, shipping_time: collection_time)
      when "Not Collected"
        Order.where('id = ?', order_id).update(status: Order.statuses[:reject], shipping_date: collection_date, shipping_time: collection_time)
      when "On Hold"
        Order.where('id = ?', order_id).update(status: Order.statuses[:holding], shipping_date: collection_date, shipping_time: collection_time)
      when "In Transit"
        Order.where('id = ?', order_id).update(status: Order.statuses[:pickup_scheduled], shipping_date: collection_date, shipping_time: collection_time)
      when "Return"
        Order.where('id = ?', order_id).update(status: Order.statuses[:returned], shipping_date: collection_date, shipping_time: collection_time)
    end

  end
end
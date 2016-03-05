class DeliveryNotifyController < ActionController::Base
  def create

    # Filtering params from Push Notification Post
    delivery_date = params[:date]
    delivery_date = Date.strptime(delivery_date, "%Y-%m-%d")
    delivery_date = delivery_date.strftime("%m/%d/%Y")

    delivery_time = params[:delivery_time]
    order_no = params[:do]
    status = params[:status]
    items = params[:items]

    logger.debug("DELIVERY NOTIFICATION:: #{params.inspect}")

    #DropOff on a new appointment
    if order_no.include?("DRP")
      db_order_no = order_no.split('-')[1]
      # Update DB
      case status
        when "Delivered"
          Order.where('id = ?', db_order_no).update(status: Order.statuses[:dropoff])
        when "In Transit"
        when "Not Delivered"
        when "On hold"
        when "Return"
      end

    #Sent Back
    else
      items.each do |item|
        po_no = item["po_no"] # order detail id
        sno = item["sno"] # barcode

        if po_no.present?
          # Update DB
          case status
            when "Delivered"
              OrderDetail.where('id = ?', po_no).update(status: OrderDetail.statuses[:delivered])
            when "In Transit"
            when "Not Delivered"
            when "On hold"
            when "Return"
          end
        end
      end
    end

  end
end
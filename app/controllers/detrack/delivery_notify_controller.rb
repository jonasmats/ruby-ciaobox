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
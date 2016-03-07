class Shipping::Schedule::DeliveryController < ScheduleController
  steps :appointment, :review, :confirmation

  include ::Dashboard::Shipping::Schedule::Parameter

  before_action :title_form, only: [:show, :update]
  before_action :check_post_params
  before_action :check_zip_code

  def create
    case step
      when :appointment

      when :review

      when :confirmation
    end
  end

  def show
    case step
      when :appointment
        load_order_detail

        # get address/state
        geocode = Geocoder.coordinates(session[:zip_code])
        result = Geocoder.search(geocode).first
        if result.present?
          @state = result.state
          @address = result.address
        end

      when :review
        if session[:delivery_step].blank? || session[:delivery_step] != 1
          redirect_to shipping_schedule_delivery_path(:appointment) and return
        end
        load_order_detail

      when :confirmation
        if session[:delivery_step].blank?
          redirect_to v1_zip_codes_path and return
        else
          if session[:delivery_step] != 2
            redirect_to shipping_schedule_delivery_path(:appointment) and return
          end
        end
        session.delete(:delivery_step)

        #Detrack Integration
        @order_details = OrderDetail.where("id IN (?)", session[:order_detail_ids])
        if exists_delivery(@order_details)
          res = create_delivery(@order_details, false)
          logger.debug("DETRACK CREATE DEBUG:: #{res.inspect}")
        else
          res = create_delivery(@order_details)
          logger.debug("DETRACK UPDATE DEBUG:: #{res.inspect}")
        end
    end
    render_wizard
  end

  def update
    case step
      when :review
        logger.debug("UPDATE REVIEW:: #{params.inspect}")
        if !update_order_detail
          redirect_to shipping_schedule_delivery_path(:appointment), alert: @error_message and return
        end

        if !update_order
          redirect_to shipping_schedule_delivery_path(:appointment), alert: @error_message and return
        end

        load_order_detail
        session[:delivery_step] = 1

      when :confirmation
        if session[:delivery_step].present? && session[:delivery_step] == 1
          update_status
          session[:delivery_step] = 2
        else
          redirect_to shipping_schedule_delivery_path(:appointment) and return
        end
    end
    render_wizard
  end

  private
  def title_form
    @title =
      case step
        when :appointment
          "When should we swing by?"
        when :review
          "Confirm Your Details"
        when :confirmation
          "Confirmation"
      end
  end

  def check_post_params
    #logger.debug("Sessionss:: #{session[:order_detail_ids].inspect}, #{params.inspect}")
    return if session.include?(:order_detail_ids)

    if params[:order_details].present? && params[:order_details][:id].present? && params[:order_details][:id].length > 0
      session[:order_detail_ids] ||= []
      params[:order_details][:id].each do |id|
        session[:order_detail_ids] << id
      end
    else
      redirect_to root_path
    end

  end

  def load_order_detail
    id = session[:order_detail_ids].at(0)
    @order_detail_for_view = OrderDetail.find(id)
    @contact_info = Order.find(@order_detail_for_view[:order_id])
    logger.debug("CONTACT INFO:: #{@contact_info.inspect}")
  end

  def update_order
    bRet = true
    @error_message = nil
    current_user.orders.find_each do |order|
      if !order.update_attributes filter_params_contact
        bRet = false
        @error_message = order.errors.full_messages
        break
      end
    end
    bRet
    #current_user.orders.update_all filter_params_contact
  end

  def update_order_detail
    bRet = true
    @error_message = nil

    @order_details = OrderDetail.where("id IN (?)", session[:order_detail_ids])
    #@order_details.update_all delivery_params

    @order_details.find_each do |detail|
      if !detail.update_attributes delivery_params
        bRet = false
        @error_message = detail.errors.full_messages
        break
      end
    end
    bRet
  end

  def update_status
    @order_details = OrderDetail.where("id IN (?)", session[:order_detail_ids])
    @order_details.update_all(:status => OrderDetail.statuses[:delivery_scheduled])
  end


  ##############################  Detrack Integration ################################
  def exists_delivery(order_details)
    one_order_detail = order_details.first

    #1
    delivery_date = Date.strptime(one_order_detail[:delivery_date], "%d.%m.%Y")
    delivery_date = delivery_date.strftime("%Y-%m-%d")

    #2
    order_no = ''
    order_details.each do |detail|
      order_no = order_no + detail[:id].to_s + '-'
    end
    len = order_no.length
    order_no = order_no[0..len - 2]

    res = Shipping::Detrack.view_delivery(delivery_date, order_no)
    res = JSON.parse res

    status = res["info"]["status"]
    failed = res["info"]["failed"]

    logger.debug("EXISTS DELIVERY:: #{res}")
    if status == "ok" && failed == 0
      return true
    else
      return false
    end
  end

  # D.O. Combination of order detail ids (172-173-174)
  def create_delivery(order_details, is_create = true)
    one_order_detail = order_details.first

    #1
    delivery_date = Date.strptime(one_order_detail[:delivery_date], "%d.%m.%Y")
    delivery_date = delivery_date.strftime("%Y-%m-%d")

    #2
    order_no = ''
    order_details.each do |detail|
      order_no = order_no + detail[:id].to_s + '-'
    end
    len = order_no.length
    order_no = order_no[0..len - 2]

    #3
    delivery_address = one_order_detail[:address]

    #4
    delivery_time = one_order_detail[:delivery_time]

    #5
    delivery_to = one_order_detail.order[:contact_name]

    #6
    phone = one_order_detail.order[:contact_phone]

    #7
    notify_email = Settings.detrack.notify_email

    #8
    notify_url = Settings.detrack.delivery_notify_url

    #9
    assign_to = one_order_detail.order.shipping.driver[:name]
    assign_to = "Driver A" if assign_to.nil?

    #10
    instructions = one_order_detail[:additional]

    #11
    zone = nil

    #12
    items = []
    order_details.each do |v|
      item = Hash.new
      item["po_no"] = v.id.to_s
      item["sku"] = Shipping::Zoho.addons[v.order_item_id.to_s]
      item["desc"] = Shipping::Zoho.addons_desc[v.order_item_id.to_s]
      item["qty"] = v.quantity
      items << item
    end
    # order_details.select("order_item_id, count(quantity) as qty").group("order_item_id").each do |v|
    #   item = Hash.new
    #   item["sku"] = Shipping::Zoho.addons[v.order_item_id.to_s]
    #   item["desc"] = Shipping::Zoho.addons_desc[v.order_item_id.to_s]
    #   item["qty"] = v.qty
    #   items << item
    # end

    logger.debug("ADD DELIVERY:: #{delivery_date}, #{order_no}, #{delivery_address}, #{delivery_time},#{delivery_to}, #{phone}, #{notify_email}, #{notify_url}, #{assign_to}, #{instructions}, #{zone}, #{items}")

    # Call a Request
    if is_create
      res = Shipping::Detrack.add_delivery(delivery_date, order_no, delivery_address, delivery_time, delivery_to, phone, notify_email, notify_url, assign_to, instructions, zone, items)
    else
      res = Shipping::Detrack.update_delivery(delivery_date, order_no, delivery_address, delivery_time, delivery_to, phone, notify_email, notify_url, assign_to, instructions, zone, items)
    end
    return res
  end
end
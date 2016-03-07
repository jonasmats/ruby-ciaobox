class Shipping::Schedule::CollectionController < ScheduleController
  steps :appointment, :review, :confirmation

  include ::Dashboard::Shipping::Schedule::Parameter

  #before_action :check_order_info, only: [:show, :update]
  before_action :title_form, only: [:show, :update]

  def show
    case step
      when :appointment
        if check_order_info?
          check_order_info
        else
          redirect_to v1_zip_codes_path and return
        end

      when :review
        if session[:collection_step].blank? || session[:collection_step] != 1
          redirect_to v1_zip_codes_path and return
        end
        check_order_info

      when :confirmation
        if session[:collection_step].blank?
          redirect_to v1_zip_codes_path and return
        else
          if session[:collection_step] != 2
            redirect_to shipping_schedule_collection_path(:appointment) and return
          end
        end
        check_order_info
        session.delete(:collection_step)

        ## Detrack Request For Collection ##
        current_user.orders.pickup_scheduled.each do |v|
          if exists_collection(v)
            res = create_collection(v, false)
            logger.debug("DETRACK UPDATE DEBUG:: #{res.inspect}")
          else
            res = create_collection(v)
            logger.debug("DETRACK CREATE DEBUG:: #{res.inspect}")
          end
        end
    end
    render_wizard
  end

  def update
    case step
      when :review
        if !update_instance
          redirect_to shipping_schedule_collection_path(:appointment), alert: @error_message and return
        end
        check_order_info
        session[:collection_step] = 1

      when :confirmation
        if session[:collection_step].present? && session[:collection_step] == 1
          #update_instance
          update_status
          session[:collection_step] = 2
        else
          redirect_to shipping_schedule_collection_path(:appointment) and return
        end
        check_order_info
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

  def update_instance
    bRet = true
    @error_message = nil

    if current_user.orders.dropoff.present?
      current_user.orders.dropoff.find_each do |order|
        if !order.update_attributes filter_params
          bRet = false
          @error_message = order.errors.full_messages
          break
        end
      end
      #current_user.orders.dropoff.update_all filter_params
    end

    if current_user.orders.pickup_scheduled.present?
      current_user.orders.pickup_scheduled.find_each do |order|
        if !order.update_attributes filter_params
          bRet = false
          @error_message = order.errors.full_messages
          break
        end
      end
      #current_user.orders.pickup_scheduled.update_all filter_params
    end
    #logger.debug("Update Instance:: #{filter_params.inspect}")
    bRet
  end

  def update_status
    if current_user.orders.dropoff.present?
      current_user.orders.dropoff.update_all(:status => Order.statuses[:pickup_scheduled])
    end
  end

  def check_order_info
    if current_user.orders.dropoff.present? || current_user.orders.pickup_scheduled.present?
      @order_for_view = current_user.orders.dropoff[0] if current_user.orders.dropoff.present?
      @order_for_view = current_user.orders.pickup_scheduled[0] if @order_for_view.nil?
    else
      redirect_to v1_zip_codes_path and return
    end
    #logger.debug("ORDER FOR VIEW:: #{@order_for_view.inspect}, #{current_user.orders.dropoff[0].inspect}")
  end

  def check_order_info?
    current_user.orders.dropoff.present? || current_user.orders.pickup_scheduled.present?
  end


  ############################## Detrack Integration ###################################
  def exists_collection(one_order)
    #1
    collection_date = Date.strptime(one_order[:shipping_date], "%d.%m.%Y")
    collection_date = collection_date.strftime("%Y-%m-%d")

    #2
    order_no = "%07d" % one_order[:id]

    res = Shipping::Detrack.view_collection(collection_date, order_no)
    res = JSON.parse res

    status = res["info"]["status"]
    failed = res["info"]["failed"]

    #logger.debug("EXISTS COLLECTION:: #{res}")
    if status == "ok" && failed == 0
      return true
    else
      return false
    end
  end

  # D.O. (7 digits) : "DOXXXXXXX"
  def create_collection(one_order, is_create = true)
    #1
    collection_date = Date.strptime(one_order[:shipping_date], "%d.%m.%Y")
    collection_date = collection_date.strftime("%Y-%m-%d")

    #2
    order_no = "%07d" % one_order[:id]

    #3
    collection_address = one_order[:address]

    #4
    collection_time = one_order[:shipping_time]

    #5
    collect_from = one_order[:contact_name]

    #6
    phone = one_order[:contact_phone]

    #7
    notify_email = Settings.detrack.notify_email

    #8
    notify_url = Settings.detrack.collection_notify_url

    #9
    #assign_to = one_order.shipping.driver[:name]
    #assign_to = "Driver A" if assign_to.nil?
    assign_to = "Driver A"

    #10
    instructions = one_order[:additional]

    #11
    zone = nil

    #12
    items = []
    one_order.order_details.each do |v|
      item = Hash.new
      item["po_no"] = v.id.to_s
      item["sku"] = Shipping::Zoho.addons[v.order_item_id.to_s]
      item["desc"] = Shipping::Zoho.addons_desc[v.order_item_id.to_s]
      item["qty"] = v.quantity
      items << item
    end
    # one_order.order_details.select("order_item_id, count(quantity) as qty").group("order_item_id").each do |v|
    #   item = Hash.new
    #   item["sku"] = Shipping::Zoho.addons[v.order_item_id.to_s]
    #   item["desc"] = Shipping::Zoho.addons_desc[v.order_item_id.to_s]
    #   item["qty"] = v.qty
    #   items << item
    # end

    # Call a Request
    if is_create
      res = Shipping::Detrack.add_collection(collection_date, order_no, collection_address, collection_time, collect_from, phone, notify_email, notify_url, assign_to, instructions, zone, items)
    else
      res = Shipping::Detrack.update_collection(collection_date, order_no, collection_address, collection_time, collect_from, phone, notify_email, notify_url, assign_to, instructions, zone, items)
    end
    return res
  end
end
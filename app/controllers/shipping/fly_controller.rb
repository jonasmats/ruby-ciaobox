class Shipping::FlyController < ShippingController
  steps :appoinment, :review, :confirmation
  include ::Dashboard::Shipping::Fly::Parameter
  before_action :title_form, only: [:show, :update]

  def show

    case step
    when :appoinment
      load_bin_order_items
      
      load_shipping
      create_instance
      list_order_items_in_order_details
      # get address/state
      # geocode = Geocoder.coordinates(session[:zip_code])
      # result = Geocoder.search(geocode).first
      # if result.present?
      #   @state = result.state
      #   @address = result.address
      # end
      @state = (@order.state.present?) ? @order.state : session[:state]
      @address = (@order.address.present?) ? @order.address : session[:address]
      @first_name = (@order.contact_name.present?) ? @order.contact_name.split(' ')[0] : session[:first_name]
      @last_name = (@order.contact_name.present?) ? @order.contact_name.split(' ')[1] : session[:last_name]
      @contact_phone = (@order.contact_phone.present?) ? @order.contact_phone : session[:contact_phone]
      @shipping_date = (@order.shipping_date.present?) ? @order.shipping_date : session[:shipping_date]
      @shipping_time = (@order.shipping_time.present?) ? @order.shipping_time : session[:shipping_time]
      @additional = (@order.additional.present?) ? @order.additional : session[:additional]

      # check if it's the very first time of order for this user
      if current_user.present?
        session[:order_count] = current_user.orders.count
      end

      if @order.persisted?
        if @order.checking?
          redirect_to shipping_fly_path(:confirmation), 
            alert: I18n.t('shipping.finish') and return
        end
      end

      if @order.order_details.empty?
        build_order_details
      end

    when :review
      authenticate_user!
      create_instance
      if @order.persisted?
        if @order.checking?
          redirect_to shipping_fly_path(:confirmation), 
            alert: I18n.t('shipping.finish') and return
        end
      else
        redirect_to shipping_fly_path(:appoinment), 
          alert: I18n.t('shipping.not_finish_step_1') and return
      end
      build_feed_back
      load_order_details

    when :confirmation
      authenticate_user!
      create_instance
      if @order.persisted?
        if @order.registering?
          redirect_to shipping_fly_path(:review), 
            alert: I18n.t('shipping.not_finish_step_2') and return
        end
      else
        redirect_to shipping_fly_path(:appoinment), 
          alert: I18n.t('shipping.not_finish_step_1') and return
      end

      #Confirm Credit card
      confirm_credit

      #Detrack Integration
      res = create_delivery(@order)
      logger.debug("DETRACK FLY DELIVERY CREATE:: #{res.inspect}")
    end
    render_wizard
  end

  def update
    case step
    when :review
      authenticate_user!
      load_shipping
      create_instance
      # delete_order_item_customer_in_order_detail
      delete_order_details
      set_params
      reset_session_temporary(true)
      # if session[:order_id].blank?
      if @order.save
        session[:order_id] = @order.id
        if order_item_user_params.present?
          create_order_item_user
        end
      else
        reset_session_temporary(false)
        redirect_to shipping_fly_path(:appoinment), 
          alert: @order.errors.full_messages and return
      end
      # end
      build_feed_back
      load_order_details


    when :confirmation
      authenticate_user!
      create_instance
      set_params

      if @order.valid?

        delete_order_details
        set_params
        @order.status = Order.statuses[:amount_confirm]
        @order.save

        #redirect back to appointment step if total amount is less than 25 CHF
        if !@order.check_amount?
          redirect_to shipping_fly_path(:review),
            notice: "Thank you for your choice. Remember that the minimum monthly fee is 25.00 CHF" and return;
        end

        #check if current user has already customer id for zoho
        addrs = @order.address.split(%r{,\s*})
        addr = {
            "street": addrs[0],
            "city": addrs[1],
            "state": @order.state,
            "zip": session[:zip_code],
            "country": addrs[3]
        }

        customer = Shipping::Zoho.retrieve_customer(current_user.customer_code)
        logger.debug("INSPECT PARAMS:: #{customer.inspect}")
        if customer.blank?

          result = Shipping::Zoho.create_customer @order.contact_name, @order.contact_email, current_user.profile.first_name,
                  current_user.profile.last_name, @order.contact_phone, addr, addr,
                  (SysSetting.first.currency == SysSetting.sys_currencies[:CHF]) ? 'CHF' : 'EUR'
          json = JSON.parse result
          customer_code = json["customer"]["customer_id"]

          @user = User.find(current_user.id)
          @user.customer_code = customer_code
          @user.save
        else
          json = JSON.parse customer
          if json["code"].to_i != 0
            result = Shipping::Zoho.create_customer @order.contact_name, @order.contact_email, current_user.profile.first_name,
                  current_user.profile.last_name, @order.contact_phone, addr, addr,
                  (SysSetting.first.currency == SysSetting.sys_currencies[:CHF]) ? 'CHF' : 'EUR'
            json = JSON.parse result
            customer_code = json["customer"]["customer_id"]

            @user = User.find(current_user.id)
            @user.customer_code = customer_code
            @user.save
          else
            result = Shipping::Zoho.update_customer current_user.customer_code, @order.contact_name, @order.contact_email, current_user.profile.first_name,
                  current_user.profile.last_name, @order.contact_phone, addr, addr,
                  (SysSetting.first.currency == SysSetting.sys_currencies[:CHF]) ? 'CHF' : 'EUR'
            json = JSON.parse result
            customer_code = json["customer"]["customer_id"]
          end
        end

        #Create a new subscription
        plan_code = Shipping::Zoho.plans[:fly]
        #starts_at = Date.strptime(@order.shipping_date, "%m/%d/%Y") + 40
        starts_at = Date.strptime(@order.shipping_date, "%d.%m.%Y") + 40
        starts_at = starts_at.strftime("%Y-%m-%d")
        addons = []
        @order.order_details.select("order_item_id, count(quantity) as qty").group("order_item_id").each do |v|
          addon = {"addon_code": Shipping::Zoho.fly_addons[v.order_item_id.to_s], "quantity": v.qty}
          addons << addon
        end
        subscription = Shipping::Zoho.create_subscription customer_code, plan_code, addons, nil, starts_at
        #logger.debug("CREATE SUBSCRIPTION:: #{subscription.inspect}, #{addons.inspect}")
        subscription = JSON.parse subscription
        subscription_id = subscription["subscription"]["subscription_id"]

        #Check if a mulitple coupon can be applied to
        # if session[:order_count] == 0
        #   m_coupon = MultipleCoupon.all.first
        #   result = Shipping::Zoho.retrieve_coupon m_coupon[:code]
        #   result = JSON.parse result
        #   if result["code"].to_i == 0
        #     res = Shipping::Zoho.assoc_coupon subscription_id, m_coupon[:code]
        #     res = JSON.parse res
        #     logger.debug("COUPON ASSOC1:: #{res}")
        #   else
        #     res = Shipping::Zoho.create_coupon m_coupon[:code], 'Gift 28.5 CHF offer', 'one_time', 'flat', m_coupon[:discount_value], Shipping::Zoho.products[:fly]
        #     res = JSON.parse res
        #     logger.debug("COUPON CREATE:: #{res}")
        #     res = Shipping::Zoho.assoc_coupon subscription_id, res["coupon"]["coupon_code"]
        #     res = JSON.parse res
        #     logger.debug("COUPON ASSOC2:: #{res}")
        #   end
        # end

        #Check if the credit card already checked
        is_checked_credit = (current_user.payment_subscriptions.all.count >= 1) ? true : false

        if !is_checked_credit
          #Create a Hosted page to checkout credit card for new subscription
          result = Shipping::Zoho.update_card_hostedpage subscription_id, Settings.zoho.hostedpage_fly_redirect
          result = JSON.parse result
          logger.debug("HOSTED PAGE:: #{result}, #{customer_code}, DBCODE:: #{current_user.customer_code}")
          if result["code"].to_i == 0
            create_subscription(subscription_id)
            redirect_to result["hostedpage"]["url"]
            return
          else
            redirect_to shipping_fly_path(:review), alert: "Error occured while processing your request, Please try it again" and return
          end
        else
          card_id = current_user.payment_subscriptions.where("card_id IS NOT NULL").first[:card_id]
          create_subscription(subscription_id, card_id)
        end

      else
        redirect_to shipping_fly_path(:review), 
          alert: @order.errors.full_messages and return
      end
    end
    render_wizard
  end;

  private
  def load_shipping
    @shipping = Shipping.find_by(zip_code: session[:zip_code])
  end

  def create_instance
    if session[:order_id].blank?
      @order = Order.new
      @order.shipping = @shipping
      @order.user = current_user
      @order.pay_status = false
      if current_user.present?
        @order.card_number = current_user.orders.where.not('card_number' => nil).order('created_at DESC').pluck(:card_number).first
      end
    else
      @order = Order.find(session[:order_id])
    end
  end

  def set_params
    @order.assign_attributes filter_params
  end

  def load_order_details
    @items = @order.order_details.includes(:order_item)
    @items_for_view = @order.order_details.select("order_item_id, count(quantity) as quantity").group("order_item_id")
  end

  def build_feed_back
     @order.build_feedback
  end

  def title_form
    @title =
      case step
      when :appoinment
        "What would you like to store?"
      when :review
        "Confirm Your Details"
      when :confirmation
        "Confirmation"
      end
  end

  def load_bin_order_items
    @bin_order_items = OrderItem::Bin.all.includes(:translations)
  end

  def build_order_details
    OrderItem.all.count(:id).times do
      @order.order_details.build
    end
  end

  def delete_order_details
    @order.order_details.destroy_all
  end

  # def delete_order_item_customer_in_order_detail
  #   list_order_items_in_order_details
  #   order_item_customer_in_order_detail_id = (@item_oders.keys & current_user.order_items.pluck(:id))
  #   if order_item_customer_in_order_detail_id.present?
  #     order_item_customer_in_order_detail_id.each do |id|
  #       OrderItem::Customer.find(id).destroy
  #     end
  #   end
  # end

  def list_order_items_in_order_details
    # @item_oders = {}
    # @order.order_details.select("order_item_id", "quantity").each do |item|
    #   @item_oders[item.order_item_id] = item.quantity
    # end
    # @item_oders

    @item_oders = {}
    @order.order_details.select("order_item_id, count(quantity) as quantity").group("order_item_id").each do |item|
      @item_oders[item.order_item_id] = item.quantity
    end
    @item_oders
  end

  def create_order_item_user
    order_item_user_params.each do |title|
      order_item_user = OrderItem::Customer.new
      order_item_user.title = title
      order_item_user.price = 6.25
      order_item_user.user = current_user
      order_item_user.avatar = File.new(Rails.public_path.join("master/order_items/other/question-ic.png"))
      order_item_user.save
      @order.order_details.create(
        order_item: order_item_user,
        quantity: 1
      )
    end
  end

  def create_subscription(subscription_id, card_id = nil)
    subscription_record = Payment::Subscription.new
    subscription_record.subscription_id = subscription_id
    subscription_record.order_id = @order.id
    subscription_record.user_id = current_user.id
    if !card_id.nil?
      subscription_record.card_id = card_id
    end
    if subscription_record.save
      session[:subscription_id] = subscription_id
    end
  end

  def confirm_credit
    customer_code = current_user.customer_code
    subscription_id = session[:subscription_id]
    subscription = Shipping::Zoho.retrieve_subscription subscription_id
    subscription = JSON.parse subscription

    subscription_record = Payment::Subscription.find_by_subscription_id(subscription_id)

    card = subscription["subscription"]["card"]
    if card.present?
      #Update a subscription
      subscription_record.update!(card_id: card["card_id"])
      #Update this Order record
      @order.update!(card_number: "XXXX-XXXX-XXXX-" + card["last_four_digits"])
    else
      card_info = Shipping::Zoho.retrieve_card(customer_code, subscription_record.card_id)
      card_info = JSON.parse card_info
      logger.debug("Retreive CARD INFO:: #{card_info}")
      #Update a subscription
      subscription_record.update!(card_id: card_info["card"]["card_id"])
      #Update this Order record
      @order.update!(card_number: "XXXX-XXXX-XXXX-" + card_info["card"]["last_four_digits"])
    end
  end

  def reset_session_temporary(is_delete)
    if !is_delete
      session[:first_name] = params[:first_name]
      session[:last_name] = params[:last_name]
      session[:address] = params[:order][:address]
      session[:state] = params[:order][:state]
      session[:contact_phone] = params[:order][:contact_phone]
      session[:shipping_date] = params[:order][:shipping_date]
      session[:shipping_time] = params[:order][:shipping_time]
      session[:additional] = params[:order][:additional]
    else
      session.delete(:first_name)
      session.delete(:last_name)
      session.delete(:address)
      session.delete(:state)
      session.delete(:contact_phone)
      session.delete(:shipping_date)
      session.delete(:shipping_time)
      session.delete(:additional)
    end
  end


  # D.O. Combination of order detail ids (172-173-174)
  def create_delivery(order, is_create = true)
    order_details = order.order_details
    one_order_detail = order_details.first

    #1
    #delivery_date = Date.strptime(order[:shipping_date], "%m/%d/%Y")
    delivery_date = Date.strptime(order[:shipping_date], "%d.%m.%Y")
    delivery_date = delivery_date.strftime("%Y-%m-%d")

    #2
    order_no = 'DRP-' + order.id.to_s

    # order_details.each do |detail|
    #   order_no = order_no + detail[:id].to_s + '-'
    # end
    # len = order_no.length
    # order_no = order_no[0..len - 2]

    #3
    delivery_address = order[:address]

    #4
    delivery_time = order[:shipping_time]

    #5
    delivery_to = order[:contact_name]

    #6
    phone = order[:contact_phone]

    #7
    notify_email = Settings.detrack.notify_email

    #8
    notify_url = Settings.detrack.delivery_notify_url

    #9
    assign_to = order.shipping.driver[:name]
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

    # Call a Request
    if is_create
      res = Shipping::Detrack.add_delivery(delivery_date, order_no, delivery_address, delivery_time, delivery_to, phone, notify_email, notify_url, assign_to, instructions, zone, items)
    else
      res = Shipping::Detrack.update_delivery(delivery_date, order_no, delivery_address, delivery_time, delivery_to, phone, notify_email, notify_url, assign_to, instructions, zone, items)
    end
    return res
  end
end

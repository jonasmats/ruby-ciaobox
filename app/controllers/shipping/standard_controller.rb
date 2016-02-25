class Shipping::StandardController < ShippingController
  # steps :appoinment, :review, :billcheck, :confirmation
  steps :appoinment, :review, :confirmation
  include ::Dashboard::Shipping::Standard::Parameter

  before_action :title_form, only: [:show, :update]

  def show

    case step
    when :appoinment
      load_box_and_bin_order_items
      load_normal_and_other_order_items
      
      load_shipping
      create_instance
      list_order_items_in_order_details
      # get address/state
      geocode = Geocoder.coordinates(session[:zip_code])
      result = Geocoder.search(geocode).first
      if result.present?
        @state = result.state
        @address = result.address
      end

      if @order.persisted?
        if @order.checking?
          redirect_to shipping_standard_path(:confirmation), 
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
          redirect_to shipping_standard_path(:confirmation), 
            alert: I18n.t('shipping.finish') and return
        end
      else
        redirect_to shipping_standard_path(:appoinment), 
          alert: I18n.t('shipping.not_finish_step_1') and return
      end
      build_feed_back
      load_order_details


    when :confirmation
      authenticate_user!
      create_instance

      if @order.persisted?
        if @order.registering?
          redirect_to shipping_standard_path(:review), 
            alert: I18n.t('shipping.not_finish_step_2') and return
        end
      else
        redirect_to shipping_standard_path(:appoinment), 
          alert: I18n.t('shipping.not_finish_step_1') and return
      end

      #Retrieve the subscription to retrieve Card Number etc again
      logger.debug("Session Subscription ID:: #{session[:subscription_id]}")
      subscription_id = session[:subscription_id]
      subscription = Shipping::Zoho.retrieve_subscription subscription_id
      subscription = JSON.parse subscription
      logger.debug("Retreive SUBSCRIPTION INFO:: #{subscription}")

      #Update a subscription
      subscription_record = Payment::Subscription.find_by_subscription_id(subscription_id)
      subscription_record.update!(
          card_id: subscription["subscription"]["card"]["card_id"],
          order_id: @order.id
      )

      #Update this Order record
      @order.update!(card_number: "XXXXXXXXXXXXX" + subscription["subscription"]["card"]["last_four_digits"])
    end
    render_wizard
  end

  def update
    case step
    when :review
      authenticate_user!
      load_shipping
      create_instance
      delete_order_item_customer_in_order_detail
      delete_order_details
      set_params
      # if session[:order_id].blank?
      if @order.save
        session[:order_id] = @order.id
        #validation checking for address, state (For Keeping Item Price)

        if order_item_user_params.present?
          create_order_item_user
        end

      else
        redirect_to shipping_standard_path(:appoinment), 
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
        #redirect back to appointment step if total amount is less than 25 CHF
        if !@order.check_amount?
          redirect_to shipping_standard_path(:review),
            alert: "Thank you for your choice. Remember that the minimum monthly fee is 25.00 CHF" and return;
        end

        delete_order_details
        set_params
        @order.status = Order.statuses[:amount_confirm]
        @order.save

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
        plan_code = Shipping::Zoho.plans[:standard]
        starts_at = Date.strptime(@order.shipping_date, "%m/%d/%Y") + 40
        starts_at = starts_at.strftime("%Y-%m-%d")
        addons = []
        @order.order_details.select("order_item_id, count(quantity) as qty").group("order_item_id").each do |v|
          addon = {"addon_code": Shipping::Zoho.addons[v.order_item_id.to_s], "quantity": v.qty}
          addons << addon
        end
        subscription = Shipping::Zoho.create_subscription customer_code, plan_code, addons, nil, starts_at
        #logger.debug("CREATE SUBSCRIPTION:: #{subscription.inspect}, #{addons.inspect}")
        subscription = JSON.parse subscription
        subscription_id = subscription["subscription"]["subscription_id"]

        #Check if the credit card already checked
        is_checked_credit = (current_user.payment_subscriptions.all.count >= 1) ? true : false

        if !is_checked_credit
          #Create a Hosted page to checkout credit card for new subscription
          result = Shipping::Zoho.update_card_hostedpage subscription_id, Settings.zoho.hostedpage_redirect
          result = JSON.parse result
          logger.debug("HOSTED PAGE:: #{result}, #{customer_code}, DBCODE:: #{current_user.customer_code}")
          if result["code"].to_i == 0
            create_subscription(subscription_id)
            redirect_to result["hostedpage"]["url"]
            return
          else
            redirect_to shipping_standard_path(:review),
              alert: "Error occured while processing your request, Please try it again" and return
          end
        else
          create_subscription(subscription_id)
        end

      else
        redirect_to shipping_standard_path(:review), 
          alert: @order.errors.full_messages and return
      end
    end
    render_wizard
  end

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
      @order.pickup_rightaway = false
      #Get the latest used credit card number
      @order.card_number = current_user.orders.where.not('card_number' => nil).order('created_at DESC').pluck(:card_number).first
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

  def load_box_and_bin_order_items
    @box_and_bin_order_items = OrderItem.box_and_bin.includes(:translations)
  end

  def load_normal_and_other_order_items
    @normal_and_other_order_items = OrderItem.normal_and_other.includes(:translations)
  end

  # def load_other_order_items
  #   @other_order_items = OrderItem::Other.all.includes(:translations)
  # end

  def build_order_details
    OrderItem.all.count(:id).times do
      @order.order_details.build
    end
  end

  def delete_order_details
    @order.order_details.destroy_all
  end

  def delete_order_item_customer_in_order_detail
    list_order_items_in_order_details
    order_item_customer_in_order_detail_id = (@item_oders.keys & current_user.order_items.pluck(:id))
    if order_item_customer_in_order_detail_id.present?
      order_item_customer_in_order_detail_id.each do |id|
        OrderItem::Customer.find(id).destroy
      end
    end
  end

  def list_order_items_in_order_details
    @item_oders = {}
    @order.order_details.select("order_item_id", "quantity").each do |item|
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

  def create_subscription(subscription_id)
    subscription_record = Payment::Subscription.new
    subscription_record.subscription_id = subscription_id
    subscription_record.user_id = current_user.id
    if subscription_record.save
      session[:subscription_id] = subscription_id
    end
  end

  def generate_postfinance_fields
    keys = ["PSPID", "ORDERID", "AMOUNT", "CURRENCY", "OPERATION", "LANGUAGE", "ACCEPTURL", "EXCEPTIONURL", "TP", "ALIAS", "ALIASUSAGE", "SHASIGN"]
    #keys = ["PSPID", "ORDERID", "AMOUNT", "CURRENCY", "OPERATION", "LANGUAGE", "EXCEPTIONURL", "TP", "SHASIGN"]
    curr_time = "#{(Time.now.to_f * 1000).to_i}"

    @hidden_f = {}
    @hidden_f["PSPID"] = Settings.postfinance.PSP
    #@hidden_f["ORDERID"] = "CB%08d" % @order.id
    @hidden_f["ORDERID"] = "CBO#{curr_time}"
    @hidden_f["AMOUNT"] = (@order.amount * 100).to_i.to_s
    @hidden_f["CURRENCY"] = "CHF"
    @hidden_f["OPERATION"] = "SAL"
    @hidden_f["LANGUAGE"] = "en_US"
    @hidden_f["ACCEPTURL"] = "http://www.ciaobox.it/shipping/standard/billcheck"
    @hidden_f["EXCEPTIONURL"] = "http://www.ciaobox.it/shipping/standard/review"
    @hidden_f["ALIAS"] = "ALIS#{curr_time}"
    @hidden_f["ALIASUSAGE"] = "Validtion of payable status"
    @hidden_f["TP"] = Settings.postfinance.TP

    shasign = ""
    keys.each do |k|
      shasign = shasign + k + "=" + @hidden_f[k].to_s + Settings.postfinance.HASHSEED
    end

    @hidden_f["SHASIGN"] = Digest::SHA1.hexdigest(shasign).upcase

    logger.debug "HASPMAP HIDDEN Fields => #{@hidden_f}"
  end
end

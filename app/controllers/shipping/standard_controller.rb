class Shipping::StandardController < ShippingController
  steps :appoinment, :review, :confirmation

  include ::Dashboard::Shipping::Standard::Parameter
  before_action :title_form, only: [:show, :update]

  def show
    case step
    when :appoinment
      @box_order_items = OrderItem::Box.all.includes(:translations)
      @normal_order_items = OrderItem::Normal.all.includes(:translations)

      load_shipping
      create_instance

      if @order.persisted?
        if @order.checking?
          redirect_to shipping_standard_path(:confirmation), 
            alert: I18n.t('shipping.finish') and return
        end
      end

      OrderItem.all.count(:id).times do
        @order.order_details.build
      end

    when :review
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
    end
    render_wizard
  end

  def update
    case step
    when :review
      load_shipping
      create_instance
      set_params
      if session[:order_id].blank?
        @order.save
        session[:order_id] = @order.id
      end
      build_feed_back
      load_order_details
    when :confirmation
      create_instance
      set_params
      @order.status = Order.statuses[:checking]
      @order.save
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
    else
      @order = Order.find(session[:order_id])
    end
  end

  def set_params
    @order.assign_attributes filter_params
  end

  def load_order_details
    @items = @order.order_details.includes(:order_item)
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
end

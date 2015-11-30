class Shipping::StandardController < ShippingController
  steps :appoinment, :review, :confirmation

  include ::Dashboard::Shipping::Standard::Parameter
  # before_action :create_instance, only: [:show, :update]
  # before_action :set_params, only: :update

  def show
    case step
    when :appoinment
      @title = "What would you like to store?"
      @box_order_items = OrderItem::Box.all.includes(:translations)
      @normal_order_items = OrderItem::Normal.all.includes(:translations)
      
      load_shipping
      create_instance

      OrderItem.all.count(:id).times do
        @order.order_details.build
      end

    when :review
      @title = "Confirm Your Details"
      create_instance
      if @order.persisted?
        if @order.checking?
          redirect_to shipping_standard_path(:confirmation) and return
        end
      else
        redirect_to shipping_standard_path(:appoinment) and return
      end
      @items = @order.order_details.includes(:order_item)
    when :confirmation
      @title = "Confirmation"
      create_instance
      if @order.persisted? && @order.registering?
        redirect_to shipping_standard_path(:review) and return
      else
        redirect_to shipping_standard_path(:appoinment) and return
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
      @order.save
      session[:order_id] = @order.id
    when :confirmation
      create_instance
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
end

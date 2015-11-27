class Shipping::StandardController < ApplicationController
  before_action :authenticate_user!

  include Wicked::Wizard
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
    when :confirmation
      @title = "Confirmation"
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
    end
    render_wizard
  end

  private
  def load_shipping
    @shipping = Shipping.find_by(zip_code: params[:zip_code])
  end

  def create_instance
    if session[:order_id].nil?
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

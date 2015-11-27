class Shipping::StandardController < ApplicationController
  include Wicked::Wizard
  steps :appoinment, :review, :confirmation

  include ::Dashboard::Shipping::Standard::Parameter
  # before_action :create_instance, only: [:show, :update]
  # before_action :set_params, only: :update

  def show
    case step
    when :appoinment
      @box_order_items = OrderItem::Box.all.includes(:translations)
      @normal_order_items = OrderItem::Normal.all.includes(:translations)
      
      create_instance

      OrderItem.all.count(:id).times do
        @order.order_details.build
      end

    when :review
      @abc = "123"
    when :confirmation
    end
    render_wizard
  end

  def update
    case step
    when :review
      create_instance
      set_params
      binding.pry
    when :confirmation
    end
    render_wizard
  end

  private
  def create_instance
    @order = Order.new
  end

  def set_params
    @order.assign_attributes private_params
  end
end

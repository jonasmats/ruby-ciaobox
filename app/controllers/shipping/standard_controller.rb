class Shipping::StandardController < ApplicationController
  include Wicked::Wizard
  steps :appoinment, :review, :confirmation

  def show
    case step
    when :appoinment
      @box_order_items = OrderItem::Box.all
      @normal_order_items = OrderItem::Normal.all
      
    when :review
      @abc = "123"
    when :confirmation
    end
    render_wizard
  end

  def update
    
  end
end

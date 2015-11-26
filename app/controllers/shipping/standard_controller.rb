class Shipping::StandardController < ApplicationController
  include Wicked::Wizard
  steps :appoinment, :review, :confirmation

  def show
    case step
    when :appoinment
    when :review
      @abc = "123"
    when :confirmation
    end
    render_wizard
  end

  def update
    
  end
end

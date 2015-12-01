class ShippingController < ActionController::Base
  layout 'application'
  before_action :authenticate_user!
  include Wicked::Wizard

  before_action :check_zip_code

  private
  def check_zip_code
    unless session[:zip_code].present?
      redirect_to root_path, notice: "Please enter zipcode"
    end
  end
end

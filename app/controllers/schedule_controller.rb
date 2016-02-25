class ScheduleController < ActionController::Base
  layout 'application'
  before_action :authenticate_user!
  include Wicked::Wizard

  private
  def check_zip_code
    unless session[:zip_code].present?
      redirect_to v1_zip_codes_path
    end
  end
end

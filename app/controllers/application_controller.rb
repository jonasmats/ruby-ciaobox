class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  private
  
  def after_sign_in_path_for(resource)
    case resource.class.name
    when CiaoboxUser::Super.name
      admin_root_path
    when CiaoboxUser::Employee.name
      employee_root_path
    when CiaoboxUser::Company.name
      admin_root_path
    when User.name
      dashboard_root_path
    end
  end

  def after_sign_out_path_for(resource)
    case resource.to_s.camelize
    when Admin.name
      new_admin_session_path
    when User.name
      root_path
    end
  end
end

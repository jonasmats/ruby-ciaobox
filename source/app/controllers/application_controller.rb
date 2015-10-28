class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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

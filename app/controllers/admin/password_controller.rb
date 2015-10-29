class Admin::PasswordController < Admin::BaseAdminController
  include ::Admin::Password::Parameter
  
  def new
  end

  def create
    change_password = ::Profile::ChangePassword.new(current_admin, private_params)
    if change_password.current_match?
      if change_password.confirm_match?
        if change_password.change
          return redirect_to admin_root_path, notice: "Change password succesfully"
        else
          msg = "Change password errors"
        end
      else
        msg = "Password new and password confirm not match"
      end
    else
      msg = "Current password wrong"
    end
    redirect_to new_admin_password_path, notice: msg
  end
end

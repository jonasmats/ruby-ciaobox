class Admin::PasswordController < Admin::BaseAdminController
  include ::Admin::Password::Parameter
  
  def new
  end

  def create
    if current_admin.valid_password? private_params[:current]
      if private_params[:new] == private_params[:confirm]
        if current_admin.update(password: private_params[:new])
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

class Admin::PasswordController < Admin::BaseAdminController
  include ::Admin::Password::Parameter

  def new
  end

  def create
    change_password = ::Profile::ChangePassword.new(current_admin, private_params)
    if change_password.current_match?
      if change_password.confirm_match?
        if change_password.change
          return redirect_to admin_root_path, notice: t('notice.admin.passwords.create.success')
        else
          msg = t('notice.admin.passwords.create.error')
        end
      else
        msg = t('notice.admin.passwords.create.error_confirm')
      end
    else
      msg = t('notice.admin.passwords.create.wrong_password')
    end
    redirect_to new_admin_password_path, notice: msg
  end
end

class Dashboard::PasswordController < Dashboard::BaseDashboardController
  include ::Dashboard::Password::Parameter

  def new
  end

  def create
    change_password = ::Profile::ChangePassword.new(current_user, private_params)
    if change_password.current_match?
      if change_password.confirm_match?
        if change_password.change
          return redirect_to dashboard_root_path, notice: t('notice.dashboard.passwords.create.success')
        else
          msg = t('notice.dashboard.passwords.create.error')
        end
      else
        msg = t('notice.dashboard.passwords.create.error_confirm')
      end
    else
      msg = t('notice.dashboard.passwords.create.wrong_password')
    end
    redirect_to new_dashboard_password_path, notice: msg
  end
end

class Admin::ImportUsersController < Admin::BaseAdminController
  def new
  end

  def create
    if params[:file].present?
      flash[:alert] = Import.import_users(params[:file])
      redirect_to admin_users_path
    else
      redirect_to new_admin_import_user_path, notice: t('admin.import_admins.error_empty')
    end
  end
end

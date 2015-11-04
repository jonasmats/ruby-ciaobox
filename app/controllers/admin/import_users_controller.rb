class Admin::ImportUsersController < Admin::BaseAdminController
  def new
  end

  def create
    if params[:file].present?
      flash[:notice] = Import.import_users(params[:file])
      redirect_to admin_users_path
    else
      redirect_to new_admin_import_user_path, notice: 'Please choice file'
    end
  end
end

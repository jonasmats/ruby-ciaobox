class Admin::ImportUsersController < Admin::BaseAdminController
  def new
  end

  def create
    Import.import_users(params[:file])
    redirect_to admin_users_path
  end
end

class Admin::ImportAdminsController < Admin::BaseAdminController
  def new
  end

  def create
    if params[:file]
      flash[:notice] = Import.import_admins(params[:file])
      redirect_to admin_admins_path
    else
      flash[:notice] = 'Please choice file'
      redirect_to new_admin_import_admin_path
    end
  end
end

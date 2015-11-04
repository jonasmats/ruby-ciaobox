class Admin::ImportAdminsController < Admin::BaseAdminController
  def new
  end

  def create
    if params[:file].present?
      flash[:alert] = Import.import_admins(params[:file])
      redirect_to admin_admins_path
    else
      redirect_to new_admin_import_admin_path, notice: 'Please choice file'
    end
  end
end

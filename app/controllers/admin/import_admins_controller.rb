class Admin::ImportAdminsController < Admin::BaseAdminController
  def new
    add_crumb I18n.t('admins.breadcrumbs.import.admin'), new_admin_import_admin_path
  end

  def create
    if params[:file].present?
      flash[:alert] = Import.import_admins(params[:file])
      redirect_to admin_admins_path
    else
      redirect_to new_admin_import_admin_path, notice: t('admin.import_admins.error_empty')
    end
  end
end

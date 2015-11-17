class Admin::ProfileController < Admin::BaseAdminController
  include ::Admin::Profile::Parameter
  add_crumb I18n.t('admins.breadcrumbs.profile'), :admin_profile_index_path
  
  before_action :load_profile

  def index
  end

  def edit
    add_crumb "#{@profile.full_name}", edit_admin_profile_path(@profile)
  end

  def update
    if @profile.update(private_params)
      redirect_to admin_profile_index_path, notice: t('notice.admin.updated', model: CiaoboxUser::Profile.human_name)
    else
      render :edit
    end
  end

  private
  def load_profile
    @profile = current_admin.profile
  end
end

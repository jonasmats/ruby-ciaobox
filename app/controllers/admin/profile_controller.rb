class Admin::ProfileController < Admin::BaseAdminController
  include ::Admin::Profile::Parameter

  before_action :load_profile

  def index
  end

  def edit
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

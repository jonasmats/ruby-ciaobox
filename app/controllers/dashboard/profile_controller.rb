class Dashboard::ProfileController < Dashboard::BaseDashboardController
  include ::Dashboard::Profile::Parameter

  before_action :load_profile
  before_action :load_address, only: :index

  def index
  end

  def edit
  end

  def update
    if @profile.update(private_params)
      redirect_to dashboard_profile_index_path, notice: t('notice.user.updated', model: User::Profile.human_name)
    else
      render :edit
    end
  end

  private
  def load_profile
    @profile = current_user.profile
  end

  def load_address
    @address = current_user.address
  end
end

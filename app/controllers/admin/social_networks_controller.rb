class Admin::SocialNetworksController < Admin::BaseAdminController
  authorize_resource
  include ::Admin::SocialNetwork::Parameter

  before_action :load_instance, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]

  def index
    @social_networks = ::SocialNetwork.all
    # .paginate(page: params[:page], per_page: Settings.per_page.admin.product)
  end

  def new
  end

  def create
    if @social_network.save
      redirect_to admin_social_networks_path, notice: t('notice.admin.created', model: SocialNetwork.human_name)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @social_network.save
      redirect_to admin_social_networks_path, notice: t('notice.admin.updated', model: SocialNetwork.human_name)
    else
      render :edit
    end
  end

  def destroy
    @social_network.destroy
    redirect_to admin_social_networks_path, notice: t('notice.admin.deleted', model: SocialNetwork.human_name)
  end

  private

  def load_instance
    @social_network = ::SocialNetwork.find(params[:id])
  end

  def create_instance
    @social_network = ::SocialNetwork.new
  end

  def set_params
    @social_network.assign_attributes private_params
  end
end

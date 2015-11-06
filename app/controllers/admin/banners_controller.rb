class Admin::BannersController < Admin::BaseAdminController
  authorize_resource class: Banner
  include ::Admin::Banners::Parameter

  before_action :load_instance, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]


  def index
    @banners = Banner.all
  end

  def show
  end

  def new
  end

  def create
    if @banner.save
      redirect_to admin_banners_path, notice: t('notice.admin.created', model: Banner.human_name)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @banner.save
      redirect_to admin_banners_path, notice: t('notice.admin.updated', model: Banner.human_name)
    else
      render :edit
    end
  end

  def destroy
    @banner.destroy
    redirect_to admin_banners_path, notice: t('notice.admin.deleted', model: Banner.human_name)
  end

  private
    def load_instance
      @banner = Banner.find(params[:id])
    end
    def create_instance
      @banner = Banner.new
    end
    def set_params
      @banner.assign_attributes private_params
    end
end

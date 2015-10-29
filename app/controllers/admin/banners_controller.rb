class Admin::BannersController < Admin::BaseAdminController
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
      redirect_to admin_banners_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @banner.save
      redirect_to admin_banners_path
    else
      render :edit
    end
  end

  def destroy
    @banner.destroy
    redirect_to admin_banners_path
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

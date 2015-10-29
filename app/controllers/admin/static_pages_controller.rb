class Admin::static_pagesController < Admin::BaseAdminController
  include ::Admin::StaticPages::Parameter

  before_action :load_static_page, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]

  def index
    @static_pages =
      if StaticPage.statuses.keys.include? params[:type]
        StaticPage.static_page_status params[:type]
      else
        StaticPage.all
      end
  end

  def show
  end

  def new
  end

  def create
    if @static_page.save
      redirect_to admin_static_page_path(@static_page), notice: "Create static page successfully" and return
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @static_page.save
      redirect_to admin_static_page_path(@static_page), notice: "Update static page successfully" and return
    else
      render :edit
    end
  end

  def destroy
    msg = 
      if @static_page.destroy
        "Destroy static page successfully"
      else
        "Destroy static page error"
      end
    redirect_to admin_static_pages_path, notice: msg
  end

  private
  def load_static_page
    @static_page = StaticPage.friendly.find(params[:id])
  end

  def create_instance
    @static_page = StaticPage.new
  end

  def set_params
    @static_page.assign_attributes private_params
  end
end

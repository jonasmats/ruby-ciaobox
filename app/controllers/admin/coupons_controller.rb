class Admin::CouponsController < Admin::BaseAdminController
  authorize_resource class: Coupon.name
  include ::Admin::Coupons::Parameter
  include ::Admin::Coupons::Finder

  add_crumb(I18n.t('admins.breadcrumbs.coupon')) { |instance| instance.send :admin_coupons_path }

  before_action :coupon_class
  before_action :load_instance, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]

  def index
    #@coupons = load_coupons
    @coupons = Coupon.all
    # .paginate(page: params[:page], per_page: Settings.per_page.admin.product)
  end

  def new
    add_crumb I18n.t('admins.breadcrumbs.new'), new_admin_coupon_path
  end

  def create
    if @coupon.save
      redirect_to admin_coupons_path, notice: t('notice.admin.created', model: Coupon.name)
    else
      render :new
    end
  end

  def edit
    add_crumb I18n.t('admins.breadcrumbs.edit'), edit_admin_coupon_path(@coupon)
  end

  def update
    if @coupon.save
      redirect_to admin_coupons_path, notice: t('notice.admin.updated', model: Coupon.name)
    else
      render :edit
    end
  end

  def destroy
    @coupon.destroy
    redirect_to admin_coupons_path, notice: t('notice.admin.deleted', model: Coupon.name)
  end

  private
  def request_object_params
    request.path.split("/")[2].singularize
  end

  def coupon_class
    request_object_params.classify.constantize
  end

  def create_instance
    @coupon = coupon_class.new
  end

  def set_params
    @coupon.assign_attributes private_params
  end
end

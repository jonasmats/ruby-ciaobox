class Admin::GiftsController < Admin::BaseAdminController
  authorize_resource class: Gift.name
  include ::Admin::Gifts::Parameter
  include ::Admin::Gifts::Finder

  add_crumb(I18n.t('admins.breadcrumbs.gifts')) { |instance| instance.send :admin_gifts_path }

  before_action :load_instance, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]

  def index
    @gifts = load_gifts
    # .paginate(page: params[:page], per_page: Settings.per_page.admin.product)
  end

  def new
    add_crumb I18n.t('admins.breadcrumbs.new'), new_admin_gift_path
  end

  def create
    if @gift.save
      redirect_to admin_gifts_path, notice: t('notice.admin.created', model: Gift.name)
    else
      render :new
    end
  end

  def edit
    add_crumb I18n.t('admins.breadcrumbs.edit'), edit_admin_gift_path(@gift)
  end

  def update
    if @gift.save
      redirect_to admin_gifts_path, notice: t('notice.admin.updated', model: Gift.name)
    else
      render :edit
    end
  end

  def destroy
    @gift.destroy
    redirect_to admin_gifts_path, notice: t('notice.admin.deleted', model: Gift.name)
  end

  private

  def create_instance
    @gift = Gift.new
  end

  def set_params
    @gift.assign_attributes private_params
  end
end

class Admin::OrdersController < Admin::BaseAdminController
  authorize_resource class: ::Order.name
  include ::Admin::Orders::Parameter
  include ::Admin::Orders::Finder

  add_crumb(I18n.t('admins.breadcrumbs.order')) { |instance| instance.send :admin_orders_path }

  before_action :load_instance, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]

  def index
    @orders = load_orders
  end

  def new
    add_crumb I18n.t('admins.breadcrumbs.new'), new_admin_order_path
  end

  def create
    if @order.save
      redirect_to admin_orders_path, notice: t('notice.admin.created', model: Order.name)
    else
      render :new
    end
  end

  def edit
    add_crumb I18n.t('admins.breadcrumbs.edit'), edit_admin_order_path(@order)
  end

  def update
    if @order.save
      redirect_to admin_orders_path, notice: t('notice.admin.updated', model: Order.name)
    else
      render :edit
    end
  end

  def destroy
    if @order.destroy
      @order.really_destroy!
    end
    redirect_to admin_orders_path, notice: t('notice.admin.deleted', model: Order.name)
  end

  private

  def load_instance
    @order = Order.find(params[:id])
  end

  def create_instance
    @order = Order.new
  end

  def set_params
    @order.assign_attributes private_params
  end
end

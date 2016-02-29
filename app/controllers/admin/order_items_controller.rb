class Admin::OrderItemsController < Admin::BaseAdminController
  include ::Admin::OrderItem::Parameter
  add_crumb(I18n.t('admins.breadcrumbs.order_item')) { |instance| instance.send :admin_order_items_path }

  before_action :load_order_item, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]


  def new
  end

  def index
    @order_items = ::OrderItem.all.includes(:translations)
  end

  def show
  end

  def edit
  end

  def create
    if @order_item.save
      redirect_to admin_order_item_path(@order_item), notice: t('notice.admin.created', model: OrderItem.human_name)
    else
      render :new
    end
  end

  def update
    if @order_item.save
      redirect_to admin_order_items_path, notice: t('notice.admin.updated', model: OrderItem.human_name)
    else
      render :edit
    end
  end

  def destroy
    msg =
      if @order_item.destroy
        t('notice.admin.admins.destroy.success')
      else
        t('notice.admin.admins.destroy.error')
      end
    redirect_to admin_order_items_path, notice: msg
  end

  private
  def load_order_item
    @order_item = ::OrderItem.find(params[:id])
  end

  def create_instance
    @order_item = ::OrderItem.new
  end

  def set_params
    @order_item.assign_attributes private_params
  end
end

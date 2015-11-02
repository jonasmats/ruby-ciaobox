class Admin::Payment::MethodsController < Admin::BaseAdminController
  include Admin::Payments::Methods::Parameter
  include Admin::Payments::Methods::Finder

  before_action :load_instance, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]

  def index
    @payment_methods = load_payment_methods
    # .paginate(page: params[:page], per_page: Settings.per_page.admin.product)
  end

  def new
  end

  def create
    if @payment_method.save
      redirect_to admin_payment_methods_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @payment_method.save
      redirect_to admin_payment_methods_path
    else
      render :edit
    end
  end

  def destroy
    @payment_method.destroy
    redirect_to admin_payment_methods_path
  end

  private

  def load_instance
    @payment_method = ::Payment::Method.find(params[:id])
  end

  def create_instance
    @payment_method = ::Payment::Method.new
  end

  def set_params
    @payment_method.assign_attributes private_params
  end
end

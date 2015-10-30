class Admin::Payment::InforsController < Admin::BaseAdminController
  include Admin::Payments::Infors::Parameter
  include Admin::Payments::Infors::Finder

  before_action :load_instance, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]

  def index
    @payment_infors = load_payment_infors
    # .paginate(page: params[:page], per_page: Settings.per_page.admin.product)
  end

  def new
  end

  def create
    if @payment_infor.save
      redirect_to admin_payment_infors_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @payment_infor.save
      redirect_to admin_payment_infors_path
    else
      render :edit
    end
  end

  def destroy
    @payment_infor.destroy
    redirect_to admin_payment_infors_path
  end

  private

  def load_instance
    @payment_infor = ::Payment::Infor.find(params[:id])
  end

  def create_instance
    @payment_infor = current_admin.payment_infors.new
  end

  def set_params
    @payment_infor.assign_attributes private_params
  end
end

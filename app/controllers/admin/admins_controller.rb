class Admin::AdminsController < Admin::BaseAdminController
  # include ::Admin::Profile::Parameter

  before_action :load_instance, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]

  def index
    @admins = 
      case current_admin.type
      when CiaoboxUser::Super.name
        Admin.all
      when CiaoboxUser::Company.name
        Admin.company_admin.employee_admins
      when CiaoboxUser::Employee.name
        Admin.employee_admins
      end
    @admins.latest
  end

  def show
    unless @admin.super? && current_admin.super?
      redirect_to admin_admins_path, notice: "Only SuperAdmin see SuperAdmin info"
    end
  end

  def new
  end

  def create
    if @emplyee_admin.save
      redirect_to admin_admin_path(@emplyee_admin), notice: "Create employee admin sucessfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @admin.save
      redirect_to admin_admin_path(@admin), notice: "Update employee admin sucessfully"
    else
      render :edit
    end
  end

  def destroy
    msg = 
      if @admin.employee?
        if @admin.destroy
          "Destroy employee admin sucessfully"
        else
          "Destroy employee admin error"
        end
      else
        "Just only delete Employee"
      end
    redirect_to admin_admins_path, notice: msg
  end

  private
  def load_instance
    @admin = Admin.find(params[:id])
  end

  def create_instance
    @admin = ::CiaoboxUser::Employee.new
  end

  def set_params
    @admin.assign_attributes private_params
  end
end

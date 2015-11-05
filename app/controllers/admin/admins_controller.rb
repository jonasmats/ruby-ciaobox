class Admin::AdminsController < Admin::BaseAdminController
  include ::Admin::Admins::Parameter

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
    @admins.latest.includes(:profile)
    @q = @admins.ransack(params[:q])
    @admins = @q.result
    respond_to do |format|
      format.html
      format.csv { send_data Export.admins_to_csv(@admins), filename: "Ciaobox_Admins_#{Time.current}.csv" }
      format.xls { send_data Export.admins_to_csv(@admins, col_sep: "\t"), filename: "Ciaobox_Admins_#{Time.current}.xls" }
    end
  end

  def show
    unless current_admin.super?
      if @admin.super?
        redirect_to admin_admins_path, notice: t('admin.admins.show.success')
      end
    end
  end

  def new
    @admin.build_profile
  end

  def create
    if @admin.save
      redirect_to admin_admin_path(@admin), notice: t('admin.admins.create.success')
    else
      render :new
    end
  end

  def edit
  end

  def import_file
    Admin.import(params[:file])
    redirect_to admin_admins_path
  end

  def update
    if @admin.save
      redirect_to admin_admin_path(@admin), notice: t('admin.admins.update.success')
    else
      render :edit
    end
  end

  def destroy
    msg =
      if @admin.employee?
        if @admin.destroy
          t('admin.admins.destroy.success')
        else
          t('admin.admins.destroy.error')
        end
      else
        t('admin.admins.destroy.not_employee')
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

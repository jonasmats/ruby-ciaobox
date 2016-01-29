class Admin::AdminsController < Admin::BaseAdminController
  authorize_resource class: Admin
  include ::Admin::Admins::Parameter

  add_crumb(I18n.t('admins.breadcrumbs.admin')) { |instance| instance.send :admin_admins_path }

  before_action :load_instance, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]
  before_action :check_permission, only: [:edit, :show, :update]

  def index
    @q = Admin.load_admins_for_manager_admin(current_admin.type).ransack(params[:q])
    @admins = @q.result.latest
    respond_to do |format|
      format.html
      format.csv { send_data Export.admins_to_csv(@admins), filename: "Ciaobox_Admins_#{Time.current}.csv" }
      format.xls { send_data Export.admins_to_csv(@admins, col_sep: "\t"), filename: "Ciaobox_Admins_#{Time.current}.xls" }
    end
  end

  def show
    add_crumb @admin.full_name, admin_admin_path(@admin)
  end

  def new
    #Generate Customer Code Automatically
    @admin.employee_code = "EMP#{(Time.now.to_f * 1000).to_i}"

    add_crumb I18n.t('admins.breadcrumbs.new'), new_admin_admin_path
    @admin.build_profile
  end

  def create
    if @admin.save
      redirect_to admin_admin_path(@admin), notice: t('notice.admin.created', model: Admin.human_name)
    else
      render :new
    end
  end

  def edit
    add_crumb @admin.full_name, edit_admin_admin_path(@admin)
  end

  def update
    if @admin.save!
      respond_to do |format|
        format.html { redirect_to admin_admin_path(@admin), notice: t('notice.admin.updated', model: Admin.human_name) }
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    msg =
      if @admin.employee?
        if @admin.destroy
          t('notice.admin.admins.destroy.success')
        else
          t('notice.admin.admins.destroy.error')
        end
      else
        t('notice.admin.admins.destroy.not_employee')
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

  def check_permission
    if current_admin.company?
      if @admin.super?
        redirect_to admin_admins_path, notice: t('notice.admin.admins.show.success')
      end
    elsif current_admin.employee?
      if @admin.super? || @admin.company?
        redirect_to admin_admins_path, notice: t('notice.admin.admins.show.success')
      end
    end
  end
end
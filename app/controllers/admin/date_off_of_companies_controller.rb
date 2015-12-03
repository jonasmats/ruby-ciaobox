class Admin::DateOffOfCompaniesController < Admin::BaseAdminController
  include ::Admin::DateOffOfCompanies::Parameter

  add_crumb(I18n.t('admins.breadcrumbs.date_off')) { |instance| instance.send :admin_date_off_of_companies_path }

  before_action :load_date_off, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]

  def index
    @date_offs = DateOff.company
  end

  def show
    add_crumb I18n.t('admins.breadcrumbs.show'), admin_date_off_of_company_path(@date_off)
  end

  def new
    add_crumb I18n.t('admins.breadcrumbs.new'), new_admin_date_off_of_company_path
  end

  def create
    if @date_off.save
      redirect_to admin_date_off_of_companies_path, notice: t('notice.admin.created', model: DateOff.human_name)
    else
      render :new
    end
  end

  def edit
    add_crumb I18n.t('admins.breadcrumbs.edit'), edit_admin_date_off_of_company_path(@date_off)
  end

  def update
    if @date_off.save
      respond_to do |format|
        format.html { redirect_to admin_date_off_of_companies_path, notice: t('notice.admin.updated', model: DateOff.human_name)}
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    @date_off.destroy
    redirect_to admin_date_off_of_companies_path, notice: t('notice.admin.deleted', model: DateOff.human_name)
  end

  private
  def load_date_off
    @date_off = DateOff.find(params[:id])
  end

  def create_instance
    @date_off = DateOff.new
  end

  def set_params
    @date_off.assign_attributes private_params
  end
end

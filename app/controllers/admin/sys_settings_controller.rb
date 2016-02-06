class Admin::SysSettingsController < Admin::BaseAdminController
  include ::Admin::SysSettings::Parameter

  add_crumb(I18n.t('admins.breadcrumbs.sys_setting')) { |instance| instance.send :admin_sys_settings_path }

  before_action :load_sys_setting, only: :update
  before_action :set_params, only: :update

  def index
    @sys_setting = SysSetting.first
    if @sys_setting.blank?
      @sys_setting = SysSetting.new
      @sys_setting.currency = SysSetting.sys_currencies[:CHF]
      @sys_setting.payment_method = SysSetting.pay_methods[:CreditCard]
      @sys_setting.timezone = "Rome"
      @sys_setting.system_language = SysSetting.sys_languages[:en];
      @sys_setting.save
    end
  end

  def update
    if @sys_setting.save
      respond_to do |format|
        format.html { redirect_to admin_sys_settings_path, notice: t('notice.admin.updated', model: SysSetting.human_name)}
        format.js
      end
    else
      render :index
    end
  end

  private
  def load_sys_setting
    @sys_setting = SysSetting.find(params[:id])
  end

  def set_params
    @sys_setting.assign_attributes private_params
  end
end
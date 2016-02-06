module Admin::SysSettings::Parameter
  extend ActiveSupport::Concern

  private
  def private_params
    params.require(:sys_setting).permit(:currency, :payment_method, :system_language, :timezone)
  end
end

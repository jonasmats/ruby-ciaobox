class Admin::BaseAdminController < ApplicationController
  before_action :authenticate_admin!
  before_action :full_name
  layout 'application.admin'

  private
  def full_name
    @admin_full_name = CiaoboxUser::Profile.find_by(admin: current_admin).full_name
  end
end

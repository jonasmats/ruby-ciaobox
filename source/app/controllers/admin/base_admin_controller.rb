class Admin::BaseAdminController < ApplicationController
  before_action :authenticate_admin!
  before_action :full_name
  before_action :avatar
  layout 'application.admin'

  private
  def profile
    CiaoboxUser::Profile.find_by(admin: current_admin)
  end
  def full_name
    @admin_full_name = profile.full_name
  end

  def avatar
    @admin_avatar = profile.avatar.url(:thumb)
  end
end

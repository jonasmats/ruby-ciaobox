class Admin::BaseAdminController < ApplicationController
  before_action :authenticate_admin!
  before_action :full_name
  before_action :avatar
  before_action :current_ability
  layout 'application.admin'

  rescue_from CanCan::AccessDenied do |exception|
    flash[:cancan] = I18n.t(:access_denied, scope: [:admin, :label])
    redirect_to admin_root_url
  end

  private

  def current_ability
    @current_ability ||= Ability.new current_admin
  end

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

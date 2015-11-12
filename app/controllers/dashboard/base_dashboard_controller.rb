class Dashboard::BaseDashboardController < ApplicationController
  layout 'application.dashboard'
  before_action :authenticate_user!
  before_action :full_name
  before_action :avatar
  before_action :current_ability

  # rescue_from CanCan::AccessDenied do |exception|
  #   flash[:cancan] = I18n.t(:access_denied, scope: [:admin, :label])
  #   redirect_to root_path
  # end

  private

  def current_ability
    @current_ability ||= Ability.new current_user
  end

  def profile
    User::Profile.find_by(user: current_user)
  end

  def full_name
    @full_name = profile.full_name
  end

  def avatar
    @user_avatar = profile.avatar.url(:thumb)
  end
end

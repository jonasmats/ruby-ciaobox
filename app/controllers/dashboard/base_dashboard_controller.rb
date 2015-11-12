class Dashboard::BaseDashboardController < ApplicationController
  layout 'application.dashboard'
  before_action :authenticate_user!
  before_action :full_name
  before_action :avatar

  private

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

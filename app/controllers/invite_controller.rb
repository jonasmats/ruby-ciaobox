class InviteController < ApplicationController

  before_action :check_params

  def index
  end

  def show
    logger.debug("INVITE:: #{params}")

  end

  private
  def check_params
    if (params[:id].present?)
      session[:coupon] = params[:id]
    end

    redirect_to new_user_registration_path
  end
end
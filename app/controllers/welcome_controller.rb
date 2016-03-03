class WelcomeController < ApplicationController
  def index
    if session[:fb_token].present? && current_user.blank?
      fb_token = session[:fb_token]
      session.delete(:fb_token)
      redirect_to "https://www.facebook.com/logout.php?next=http://localhost:3000/&access_token=#{fb_token}" and return
    end
  end
end

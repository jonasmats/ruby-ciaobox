class Auth::SessionsController < Devise::SessionsController
  #before_filter :configure_sign_in_params, only: [:create]
  #after_action :destroy_social_logins, only: [:destroy]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  def destroy

    #check if facebook or google+ auth session
    if session[:fb_token].present?
      fb_token = session[:fb_token]
      session.delete(:fb_token)
    end

    if session[:google_token].present?
      google_token = session[:google_token]
      session.delete(:google_token)

      sign_out_google(google_token)
    end

    super

    if fb_token.present?
      session[:fb_token] = fb_token
    end

  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end

  private
  def sign_out_google(google_token)
    url_str = "https://accounts.google.com/o/oauth2/revoke?token=" + google_token
    uri = URI(url_str)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Get.new(uri)
      http.request(req)
    end
    logger.debug("FB RESPONSE:: #{res.body}")
    return res.body
  end
end

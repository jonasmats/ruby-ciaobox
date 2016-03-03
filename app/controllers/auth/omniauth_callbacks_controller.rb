class Auth::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_process('facebook')
  end

  def google_oauth2
    callback_process('google_oauth2')
  end

  private 
  def callback_process(provider)
    auth = request.env["omniauth.auth"]
    user = User.from_omniauth(auth)
    logger.debug("AUTHORIZATION:: #{auth.inspect}")
    if user.persisted?
      # unless user.profile.present?
      #   user.create_profile(
      #     first_name: auth.info.first_name,
      #     last_name: auth.info.last_name,
      #     avatar: process_uri(auth.info.image)
      #   )
      # end
      if user.profile.present?
        User::Profile.update(user.profile.id,
                             :first_name => auth.info.first_name,
                             :last_name => auth.info.last_name,
                             :avatar => process_uri(auth.info.image)
        )
      else
        user.create_profile(
            first_name: auth.info.first_name,
            last_name: auth.info.last_name,
            avatar: process_uri(auth.info.image)
        )
      end

      if provider == 'facebook'
        session[:fb_token] = auth["credentials"]["token"]
      else
        session[:google_token] = auth["credentials"]["token"]
      end

      sign_in_and_redirect user
    else
      session["devise.#{provider}_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def process_uri(uri)
    avatar_url = URI.parse(uri)
    avatar_url.scheme = 'https'
    avatar_url.to_s
  end
end

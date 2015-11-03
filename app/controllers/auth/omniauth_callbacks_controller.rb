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
    binding.pry
    user = User.from_omniauth(auth)
    if user.persisted?
      unless user.profile.present?
        user.create_profile(
          first_name: auth.info.name
        )
      end
      sign_in_and_redirect user
    else
      session["devise.#{provider}_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end

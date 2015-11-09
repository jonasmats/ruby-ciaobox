class SetLanguageController < ApplicationController
  def en
    I18n.locale = :en
    set_session_and_redirect
  end

  def it
    I18n.locale = :it
    set_session_and_redirect
  end

  def fr
    I18n.locale = :fr
    set_session_and_redirect
  end

  def de
    I18n.locale = :de
    set_session_and_redirect
  end

  private
    def set_session_and_redirect
      session[:locale] = I18n.locale
      redirect_to :back
      rescue ActionController::RedirectBackError
        redirect_to :root
    end
end

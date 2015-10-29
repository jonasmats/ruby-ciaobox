module Admin::Password::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:ciaobox_user_password]
        params.require(:ciaobox_user_password).permit(:current, :new, :confirm)
      end
    end
end

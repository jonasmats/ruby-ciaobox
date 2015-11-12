module Dashboard::Password::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:user]
        params.require(:user).permit(:current, :new, :confirm)
      end
    end
end

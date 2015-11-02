module Admin::Users::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:user]
        params.require(:user)
          .permit(:email, :status, :password, 
            profile_attributes: [:id, :first_name, :last_name, :username, :avatar, :user_id])
      end
    end
end

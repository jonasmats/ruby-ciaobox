module Admin::Employee::Users::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:user]
        params.require(:user)
          .permit(:email, :username, :status, :password, note: params[:user][:note].keys[0..3],
            profile_attributes: [:id, :first_name, :last_name, :telephone, :user_id, :avatar])
      end
    end
end

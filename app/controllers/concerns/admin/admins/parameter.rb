module Admin::Admins::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:ciaobox_user_employee]
        params.require(:ciaobox_user_employee)
          .permit(:email, :username, :status, :password, 
            profile_attributes: [:id, :first_name, :last_name, :avatar, :admin_id])
      end
    end
end

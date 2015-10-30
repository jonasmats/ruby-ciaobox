module Admin::Admins::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:ciaobox_user_employee]
        params.require(:ciaobox_user_employee)
          .permit(:email, :status, :password, 
            profile_attributes: [:id, :first_name, :last_name, :username, :avatar, :admin_id])
      end
    end
end

module Admin::Admins::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:ciaobox_user_super]
        params.require(:ciaobox_user_super)
          .permit(:email, :username, :status, :password, 
            profile_attributes: [:id, :first_name, :last_name, :avatar, :admin_id])
      elsif params[:ciaobox_user_company]
        params.require(:ciaobox_user_company)
          .permit(:email, :username, :status, :password, 
            profile_attributes: [:id, :first_name, :last_name, :avatar, :admin_id])
      elsif params[:ciaobox_user_employee]
        params.require(:ciaobox_user_employee)
          .permit(:email, :username, :status, :password, 
            profile_attributes: [:id, :first_name, :last_name, :avatar, :admin_id])
      end
    end
end

module Admin::Employee::Users::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:user]
        note = params[:user][:note].present? ? params[:user][:note].keys[0..3] : nil
        params.require(:user)
          .permit(:email, :username, :status, :password, :cap, note: note,
            profile_attributes: [:id, :first_name, :last_name, :telephone, :user_id, :avatar],
            address_attributes: [:id, :address_name, :city, :country, :user_id])
      end
    end
end

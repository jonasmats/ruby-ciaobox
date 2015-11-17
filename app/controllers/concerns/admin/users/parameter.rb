module Admin::Users::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:user]
        note = params[:user][:note].present? ? params[:user][:note].keys[0..3] : nil
        params.require(:user)
          .permit(:email, :username, :status, :password, note: note,
            profile_attributes: [:id, :first_name, :last_name, :telephone, :user_id, :avatar],
            address_attributes: [:id, :cap, :address_name, :city, :country, :user_id])
      end
    end

    def log_params
      if params[:user]
        note = params[:user][:note].present? ? params[:user][:note].keys[0..3] : nil
        params.require(:user)
          .permit(:email, :username, :status, :cap, note: note,
            profile_attributes: [:id, :first_name, :last_name, :telephone, :user_id, :avatar],
            address_attributes: [:id, :cap, :address_name, :city, :country, :user_id])
      end
    end
end

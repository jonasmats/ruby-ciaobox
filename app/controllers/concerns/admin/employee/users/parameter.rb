module Admin::Employee::Users::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:user]
        note = params[:user][:note].present? ? params[:user][:note].keys[0..3] : nil
        params.require(:user)
          .permit(:email, :username, :status, :password, note: note,
            profile_attributes: [:id, :first_name, :last_name, :telephone, :user_id, :avatar, :preferred_language],
            address_attributes: [:id, :cap, :address_name, :city, :country, :user_id],
            orders_attributes: [:id, :user_id, :shipping_id, :pay_status, :shipping_date, :shipping_time, :address, :state, :contact_name, :contact_email, :contact_phone]
          )
      end
    end

    def log_params
      if params[:user]
        note = params[:user][:note].present? ? params[:user][:note].keys[0..3] : nil
        params.require(:user)
          .permit(:email, :username, :status, :cap, note: note,
            profile_attributes: [:id, :first_name, :last_name, :telephone, :user_id, :preferred_language],
            address_attributes: [:id, :cap, :address_name, :city, :country, :user_id],
            orders_attributes: [:id, :user_id, :shipping_id, :pay_status, :shipping_date, :shipping_time, :address, :state, :contact_name, :contact_email, :contact_phone]
          )
      end
    end
end

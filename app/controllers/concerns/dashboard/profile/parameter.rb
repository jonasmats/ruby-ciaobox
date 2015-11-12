module Dashboard::Profile::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:user_profile]
        params.require(:user_profile).permit(:first_name, :last_name, :avatar,
          address_attributes: [:id, :address_name, :city, :country]
        )
      end
    end
end

module Admin::Profile::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:ciaobox_user_profile]
        params.require(:ciaobox_user_profile).permit(:first_name, :last_name, :avatar)
      end
    end
end

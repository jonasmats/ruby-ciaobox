module Admin::SocialNetwork::Parameter
  extend ActiveSupport::Concern

  private

  def private_params
    if params[:social_network]
      params.require(:social_network).permit(:name, :link, :icon)
    end
  end
end

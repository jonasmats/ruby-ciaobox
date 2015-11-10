class V1::SocialNetworksController < V1::BaseController
  respond_to :json

  def index
    @social_networks = SocialNetwork.all
  end
end

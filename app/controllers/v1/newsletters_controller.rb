class V1::NewslettersController < V1::BaseController

  def create
    if params[:email].present?
      newsletter =  Newsletter.create!(email: params[:email])
      SubscribeNewslettersJob.perform_later(params[:email])
      if newsletter.present?
        render json: {code: 100, data: "Register successfully"}
      else
        render json: {code: 200, data: "Register not successfully"}
      end
    else
      render json: {code: 300, data: "Missing params email"}
    end
  end
end

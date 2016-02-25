class V1::ZipCodesController < V1::BaseController

  def index
  end

  def create
    if params[:zip_code].present?
      shipping =  Shipping.find_by(zip_code: params[:zip_code])
      if shipping.present?
        session[:zip_code] = params[:zip_code]
        if session.include?(:order_detail_ids)
          render json: {code: 100, data: "schedule-delivery"}
        else
          render json: {code: 100, data: shipping.way}
        end
      else
        render json: {code: 200, data: "the ZIP code is not in my shipping list"}
      end
    else
      render json: {code: 300, data: "Missing params zip_code"}
    end
  end
end

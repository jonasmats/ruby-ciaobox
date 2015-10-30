module Admin::Payments::Infors::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:payment_infor]
        params.require(:payment_infor).permit(:payment_method_id, :infors)
      end
    end
end

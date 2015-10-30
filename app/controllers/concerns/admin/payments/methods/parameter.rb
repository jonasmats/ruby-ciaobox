module Admin::Payments::Methods::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:payment_method]
        params.require(:payment_method).permit(:payment_type, :name)
      end
    end
end

module Admin::Orders::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:order]
        params.require(:order).permit(:order_category_id])
      end
    end
end

module Dashboard::Shipping::Standard::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:order]
        params.require(:order).permit(:shipping_date, :shipping_time, :address, 
          :state, :additional, :amount,
          order_details_attributes: [:id, :quantity, :order_item_id]
        )
      end
    end
end

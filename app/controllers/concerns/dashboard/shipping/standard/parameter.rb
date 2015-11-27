module Dashboard::Shipping::Standard::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:order]
        params.require(:order).permit(:shipping_date, :shipping_time,
          :address, :state, :additional, :amount,
          order_details_attributes: [:id, :quantity, :order_item_id]
        )
      end
    end
    
    def filter_params
    filted = private_params.clone
    filted[:order_details_attributes].each do |k, v|
      # v = {"quantity"=>"2", "order_item_id"=>"2"}
      if v[:quantity].to_i == 0
        filted[:order_details_attributes].delete(k)
      end
    end
    filted
  end
end

module Dashboard::Shipping::Standard::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:order]
        params.require(:order).permit(:shipping_date, :shipping_time,
          :address, :state, :additional, :save_image,
          :contact_name, :contact_email, :contact_phone,
          order_details_attributes: [:id, :quantity, :order_item_id],
          feedback_attributes: [:id, :content]
        )
      end
    end
    
    def filter_params
    filted = private_params.clone
    return filted if filted[:order_details_attributes].nil?
    filted[:order_details_attributes].each do |k, v|
      # v = {"quantity"=>"2", "order_item_id"=>"2"}
      if v[:quantity].to_i == 0
        filted[:order_details_attributes].delete(k)
      end
    end
    filted
  end
end

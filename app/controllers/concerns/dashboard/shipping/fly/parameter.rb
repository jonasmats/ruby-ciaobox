module Dashboard::Shipping::Fly::Parameter
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

    filted_temp = Hash.new

    logger.debug("FILTERED:: #{filted[:order_details_attributes]}")

    filted[:order_details_attributes].each do |k, v|
      # v = {"quantity"=>"2", "order_item_id"=>"2"}
      if v[:quantity].to_i == 0
        filted[:order_details_attributes].delete(k)
      end

      item_id = v[:order_item_id]
      qty = v[:quantity].to_i
      if qty > 0
        filted[:order_details_attributes].delete(k)
      end

      (1..qty).each do |i|
        one_order_detail = Hash.new
        one_order_detail[:quantity] = "1"
        one_order_detail[:order_item_id] = item_id
        kk = k + '_' + i.to_s
        filted_temp[kk] = one_order_detail
      end
    end

    filted_temp.each do |k, v|
      filted[:order_details_attributes][k] = v
    end

    if params[:first_name].present? && params[:last_name].present?
      filted[:contact_name] = params[:first_name] + ' ' + params[:last_name]
    end

    #logger.debug("STANDARD FILTERED:: #{filted.inspect}")
    filted
  end

  def order_item_user_params
    if params.keys.include? "order_items_user"
      params.require(:order_items_user)
    end
  end
end

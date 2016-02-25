module Dashboard::Shipping::Schedule::Parameter
  extend ActiveSupport::Concern

  private
  def private_params
    if params[:order]
      params.require(:order).permit(
          :shipping_date, :shipping_time, :pickup_rightaway,
          :address, :state, :additional,
          :contact_name, :contact_email, :contact_phone
      )
    end
  end

  def delivery_params
    if params[:order_detail]
      params.require(:order_detail).permit(
          :delivery_date, :delivery_time,
          :address, :state, :additional
      )
    end
  end

  def contact_info_params
    params.permit(:contact_name, :contact_email, :contact_phone)
  end

end

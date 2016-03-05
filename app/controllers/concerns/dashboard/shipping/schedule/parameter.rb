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

  public
  def filter_params
    filted = private_params.clone
    if params[:first_name].present? && params[:last_name].present?
      filted[:contact_name] = params[:first_name] + ' ' + params[:last_name]
    end

    filted
  end

  def delivery_params
    logger.debug("delivery INFO PARAMS:: #{params[:order_detail]}")
    if params[:order_detail]
      params.require(:order_detail).permit(
          :delivery_date, :delivery_time,
          :address, :state, :additional
      )
    end
  end

  def contact_info_params
    #logger.debug("CONTACT INFO PARAMS:: #{params.inspect}")
    params.permit(:contact_name, :contact_email, :contact_phone)
  end

  def filter_params_contact
    filted = contact_info_params.clone
    if params[:first_name].present? && params[:last_name].present?
      filted[:contact_name] = params[:first_name] + ' ' + params[:last_name]
    end

    filted
  end
end

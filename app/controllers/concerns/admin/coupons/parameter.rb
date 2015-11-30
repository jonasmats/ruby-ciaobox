module Admin::Coupons::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[request_object_params.to_sym]
        case request_object_params
        when "multiple_coupon"
          params.require(request_object_params.to_sym).permit(default_update_attributes)
        when "custom_coupon"
          params.require(request_object_params.to_sym).permit(default_update_attributes,
            :start_date, :end_date)
        when "custom_gift"
          params.require(request_object_params.to_sym).permit(*default_update_attributes, 
            gifts_coupons_attributes: [:id, :gift_id, :amount])
        end
      end
    end

    def default_update_attributes
      [:code, :discount_type, :discount_value, translations_attributes: [:id, :locale, :name]]
    end
end

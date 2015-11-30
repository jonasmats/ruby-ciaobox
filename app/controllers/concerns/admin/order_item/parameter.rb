module Admin::OrderItem::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:order_item]
        params.require(:order_item).permit(:title, :avatar, :price, :type, translations_attributes: [:id, :locale, :title, :description])
      end
    end
end

module Admin::OrderItem::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:order_item]
        permitted_params = params.require(:order_item).permit(:title, :avatar, :price, :type, translations_attributes: [:id, :locale, :title, :description])
      end
      if params[:order_item_bin]
        permitted_params = params.require(:order_item_bin).permit(:title, :avatar, :price, :type, translations_attributes: [:id, :locale, :title, :description])
      end
      if params[:order_item_box]
        permitted_params = params.require(:order_item_box).permit(:title, :avatar, :price, :type, translations_attributes: [:id, :locale, :title, :description])
      end
      if params[:order_item_customer]
        permitted_params = params.require(:order_item_customer).permit(:title, :avatar, :price, :type, translations_attributes: [:id, :locale, :title, :description])
      end
      if params[:order_item_normal]
        permitted_params = params.require(:order_item_normal).permit(:title, :avatar, :price, :type, translations_attributes: [:id, :locale, :title, :description])
      end
      if params[:order_item_other]
        permitted_params = params.require(:order_item_other).permit(:title, :avatar, :price, :type, translations_attributes: [:id, :locale, :title, :description])
      end
      permitted_params
    end
end

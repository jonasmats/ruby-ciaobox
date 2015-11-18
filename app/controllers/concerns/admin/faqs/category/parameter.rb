module Admin::Faqs::Category::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:faq_category]
        params.require(:faq_category).permit(translations_attributes: [:id, :locale, :name])
      end
    end
end

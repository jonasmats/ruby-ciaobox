module Admin::Faqs::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:faq]
        params.require(:faq).permit(:faq_category_id, :question, :answer)
      end
    end
end

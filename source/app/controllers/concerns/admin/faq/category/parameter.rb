module Faq::Category::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:faq_category]
        params.require(:faq_category).permit(:name)
      end
    end
end

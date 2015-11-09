class V1::FaqsController < V1::BaseController
  def index
    @categories = Faq::Category.includes(:faqs).all
  end
end

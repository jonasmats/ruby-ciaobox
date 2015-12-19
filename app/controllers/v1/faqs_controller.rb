class V1::FaqsController < V1::BaseController
  def index
    @categories = Faq::Category.includes(:faqs).all.order_by_id_desc
  end
end

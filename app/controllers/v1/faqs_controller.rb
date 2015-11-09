class V1::FaqsController < V1::BaseController
  include ::Admin::Faqs::Finder

  def index
    @faqs = load_faqs
  end
end

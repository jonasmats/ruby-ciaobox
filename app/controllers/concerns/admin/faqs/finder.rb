module Admin::Faqs::Finder
  extend ActiveSupport::Concern
  def load_faqs
    ::Faq.includes(:faq_category).all
  end
end
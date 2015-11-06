module Admin::Faqs::Finder
  extend ActiveSupport::Concern
  def load_faqs
    ::Faq.all
  end
end
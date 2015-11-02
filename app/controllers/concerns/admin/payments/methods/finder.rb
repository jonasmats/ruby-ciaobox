module Admin::Payments::Methods::Finder
  extend ActiveSupport::Concern

  def load_payment_methods
    ::Payment::Method.all
  end
end
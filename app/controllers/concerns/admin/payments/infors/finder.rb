module Admin::Payments::Infors::Finder
  extend ActiveSupport::Concern
  def load_payment_infors
    ::Payment::Infor.all
  end
end

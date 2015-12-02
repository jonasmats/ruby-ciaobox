module Admin::Orders::Finder
  extend ActiveSupport::Concern
  def load_orders
    ::Order.all.includes(:user).page(params[:page]).per(20)
  end
end
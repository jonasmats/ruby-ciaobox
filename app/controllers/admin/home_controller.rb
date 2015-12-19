class Admin::HomeController < Admin::BaseAdminController
  def index
    @user_count = User.count
    @orders = Order.all
    @revenue = @orders.sum(:amount)
  end
end

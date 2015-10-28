class Dashboard::HomeController < Dashboard::BaseDashboardController
  def index
    render plain: "Hello User"
  end
end

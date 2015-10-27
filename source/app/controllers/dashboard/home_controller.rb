class Dashboard::HomeController < Dashboard::BaseEmployeeController
  def index
    render plain: "Hello User"
  end
end

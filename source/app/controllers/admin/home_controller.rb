class Admin::HomeController < Admin::BaseAdminController
  def index
    render plain: "Hello Admin"
  end
end

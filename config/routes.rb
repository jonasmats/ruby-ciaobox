# create by NVTAnh at 27/10/2015
class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  root 'welcome#index'

  draw :admin_routes
  draw :employee_routes
  draw :dashboard_routes
  draw :public_routes
  draw :devise_routes
  draw :api_v1
end

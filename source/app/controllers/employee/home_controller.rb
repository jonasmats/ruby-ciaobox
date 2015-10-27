class Employee::HomeController < Employee::BaseEmployeeController
  def index
    render plain: "Hello Employee"
  end
end

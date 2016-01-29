class AddEmployeeCodeToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :employee_code, :string
  end
end

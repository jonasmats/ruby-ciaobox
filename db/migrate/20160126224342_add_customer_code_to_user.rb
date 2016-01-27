class AddCustomerCodeToUser < ActiveRecord::Migration
  def change
    add_column :users, :customer_code, :string
  end
end

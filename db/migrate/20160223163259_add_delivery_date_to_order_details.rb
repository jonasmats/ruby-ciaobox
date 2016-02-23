class AddDeliveryDateToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :delivery_date, :string
    add_column :order_details, :delivery_time, :string
    add_column :order_details, :address, :string
    add_column :order_details, :state, :string
    add_column :order_details, :status, :integer
  end
end

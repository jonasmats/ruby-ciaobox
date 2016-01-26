class AddPickupRightawayToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :pickup_rightaway, :boolean
  end
end

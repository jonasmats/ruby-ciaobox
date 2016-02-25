class AddAdditionalToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :additional, :text
  end
end

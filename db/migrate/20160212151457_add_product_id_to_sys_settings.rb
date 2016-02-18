class AddProductIdToSysSettings < ActiveRecord::Migration
  def change
    add_column :sys_settings, :product_id, :string
  end
end

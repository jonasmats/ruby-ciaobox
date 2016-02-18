class AddVatPercentToSysSettings < ActiveRecord::Migration
  def change
    add_column :sys_settings, :vat_percent, :integer
  end
end

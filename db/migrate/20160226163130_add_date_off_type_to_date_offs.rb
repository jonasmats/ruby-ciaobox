class AddDateOffTypeToDateOffs < ActiveRecord::Migration
  def change
    add_column :date_offs, :date_off_type, :integer
  end
end

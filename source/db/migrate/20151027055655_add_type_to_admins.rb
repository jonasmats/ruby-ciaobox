class AddTypeToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :type, :string
  end
end

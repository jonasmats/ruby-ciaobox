class AddCardNameToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :card_name, :string
  end
end

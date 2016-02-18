class AddCardStreetToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :card_street, :string
  end
end

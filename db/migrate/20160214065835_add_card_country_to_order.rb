class AddCardCountryToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :card_country, :string
  end
end

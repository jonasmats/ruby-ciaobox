class AddCardCityToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :card_city, :string
  end
end

class AddCardSurnameToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :card_surname, :string
  end
end

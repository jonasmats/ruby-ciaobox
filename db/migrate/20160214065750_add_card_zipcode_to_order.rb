class AddCardZipcodeToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :card_zipcode, :string
  end
end

class CreateOrderDetails < ActiveRecord::Migration
  def change
    create_table :order_details do |t|
      t.references :order, index: true, foreign_key: true
      t.references :order_item, index: true, foreign_key: true
      t.float :price
      t.integer :quantity
      t.string :barcode

      t.timestamps null: false
    end
  end
end

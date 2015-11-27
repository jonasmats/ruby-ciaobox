class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.float :price
      t.attachment :avatar
      t.string :type

      t.timestamps null: false
    end
    OrderItem.create_translation_table! title: :string, description: :text
  end
end

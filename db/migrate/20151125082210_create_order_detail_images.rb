class CreateOrderDetailImages < ActiveRecord::Migration
  def change
    create_table :order_detail_images do |t|
      t.references :order_item, index: true, foreign_key: true
      t.attachment :image
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end

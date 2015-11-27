class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.references :shipping, index: true, foreign_key: true
      t.integer :pay_status, null: false
      t.string :shipping_date, null: false
      t.string :shipping_time, null: false
      t.datetime :start_date_keep
      t.datetime :end_date_keep
      t.float :amount
      t.string :address
      t.string :state
      t.boolean :save_image, default: false, null: false
      t.integer :status, default: 0
      t.text :additional

      t.timestamps null: false
    end
  end
end


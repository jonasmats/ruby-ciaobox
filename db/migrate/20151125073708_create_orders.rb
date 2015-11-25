class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true, unique: :true
      t.references :shipping, index: true, foreign_key: true, unique: :true
      t.integer :pay_status
      t.datetime :order_at
      t.datetime :start_date
      t.datetime :end_date
      t.integer :amount
      t.string :address
      t.string :state
      t.boolean :save_image
      t.integer :status
      t.text :additional

      t.timestamps null: false
    end
  end
end


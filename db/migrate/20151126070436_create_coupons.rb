class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code
      t.date :start_date
      t.date :end_date
      t.string :type
      t.integer :discount_type
      t.string :discount_value

      t.timestamps null: false
    end
    Coupon.create_translation_table! name: :string
  end
end

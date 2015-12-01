class CreateCouponHistories < ActiveRecord::Migration
  def change
    create_table :coupon_histories do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id
      t.integer :coupon_id

      t.timestamps null: false
    end
  end
end

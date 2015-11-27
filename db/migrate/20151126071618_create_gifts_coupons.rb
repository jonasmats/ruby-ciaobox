class CreateGiftsCoupons < ActiveRecord::Migration
  def change
    create_table :gifts_coupons do |t|
      t.references :gift, index: true, foreign_key: true
      t.integer :custom_gift_id, index: true, foreign_key: true
      t.integer :amount, null: false

      t.timestamps null: false
    end
  end
end

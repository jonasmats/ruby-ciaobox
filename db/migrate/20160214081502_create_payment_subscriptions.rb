class CreatePaymentSubscriptions < ActiveRecord::Migration
  def change
    create_table :payment_subscriptions do |t|
      t.string :subscription_id
      t.string :card_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

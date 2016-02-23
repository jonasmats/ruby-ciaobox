class AddDeletedAtToPaymentSubscriptions < ActiveRecord::Migration
  def change
    add_column :payment_subscriptions, :deleted_at, :timestamp
  end
end

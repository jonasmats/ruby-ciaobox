class AddOrderToPaymentSubscriptions < ActiveRecord::Migration
  def change
    add_reference :payment_subscriptions, :order, index: true, foreign_key: true
  end
end

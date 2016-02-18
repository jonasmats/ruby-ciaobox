class CreatePaymentInvoices < ActiveRecord::Migration
  def change
    create_table :payment_invoices do |t|
      t.string :invoice_id
      t.references :payment_subscription, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

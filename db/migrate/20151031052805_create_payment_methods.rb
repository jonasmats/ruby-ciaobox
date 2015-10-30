class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.integer :payment_type
      t.string  :name
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :payment_methods, [:payment_type, :name], unique: true
  end
end

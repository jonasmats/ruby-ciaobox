class CreatePaymentInfors < ActiveRecord::Migration
  def change
    create_table :payment_infors do |t|
      t.references :owner, polymorphic: true, null: false
      t.references :payment_method, null: false, foreign_key: true
      t.hstore :infors, null: false

      t.timestamps null: false
    end

    add_index :payment_infors, [:owner_id, :owner_type, :payment_method_id], name: 'index_for_payment_infors'
  end
end

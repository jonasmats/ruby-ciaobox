class CreateSysSettings < ActiveRecord::Migration
  def change
    create_table :sys_settings do |t|
      t.integer :currency
      t.integer :payment_method
      t.string :timezone
      t.integer :system_language
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end

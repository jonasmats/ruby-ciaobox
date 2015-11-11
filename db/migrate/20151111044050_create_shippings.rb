class CreateShippings < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
      t.string :zip_code, null: false
      t.integer :way, null: false, default: 0
      t.references :driver, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end

class CreateShippings < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
      t.string :zip_code, null: false
      t.string :way, null: false

      t.timestamps null: false
    end
  end
end

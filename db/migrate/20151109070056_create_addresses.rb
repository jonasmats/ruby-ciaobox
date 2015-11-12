class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :user, index: true, foreign_key: true
      t.string :address_name
      t.string :city
      t.string :country

      t.timestamps null: false
    end
  end
end

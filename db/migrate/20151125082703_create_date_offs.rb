class CreateDateOffs < ActiveRecord::Migration
  def change
    create_table :date_offs do |t|
      t.date :start_at, null: false
      t.date :end_at, null: false
      t.integer :date_off_type

      t.timestamps null: false
    end
  end
end

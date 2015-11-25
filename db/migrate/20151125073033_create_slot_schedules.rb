class CreateSlotSchedules < ActiveRecord::Migration
  def change
    create_table :slot_schedules do |t|
      t.references :slot_time, index: true, foreign_key: true, null: false
      t.references :driver, index: true, foreign_key: true, null: false
      t.integer :limit, null: false
      t.integer :slot_date, null: false

      t.timestamps null: false
    end
  end
end

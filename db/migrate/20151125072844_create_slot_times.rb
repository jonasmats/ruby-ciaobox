class CreateSlotTimes < ActiveRecord::Migration
  def change
    create_table :slot_times do |t|
      t.string :start_at, null: false
      t.string :end_at, null: false

      t.timestamps null: false
    end
  end
end

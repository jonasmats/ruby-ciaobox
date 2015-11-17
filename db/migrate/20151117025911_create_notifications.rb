class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.hstore :info, default: {}, null: false
      t.integer :status, default: 0, null: false
      t.string :type
      t.timestamps null: false
    end
  end
end

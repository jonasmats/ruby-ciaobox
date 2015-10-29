class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :role, index: true, foreign_key: true, null: false
      t.string :entity, index: true, null: false
      t.hstore :settings
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :permissions, [:role_id, :entity], unique: true
  end
end

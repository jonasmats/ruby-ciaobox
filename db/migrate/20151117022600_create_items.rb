class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :type, null: false
      t.hstore :data, null: false

      t.timestamps null: false
    end
  end
end

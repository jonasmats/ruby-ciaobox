class CreateLogActions < ActiveRecord::Migration
  def change
    create_table :log_actions do |t|
      t.integer :owner_id
      t.string :action_type
      t.integer :subject_id
      t.string :subject_type
      t.text :summary
      t.hstore :data

      t.timestamps null: false
    end
  end
end

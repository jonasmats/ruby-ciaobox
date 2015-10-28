class CreateCiaoboxUserProfile < ActiveRecord::Migration
  def change
    create_table :ciaobox_user_profiles do |t|
      t.references :admin, index: true, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.timestamps null: false
    end
  end
end

class CreateCiaoboxUserProfile < ActiveRecord::Migration
  def change
    create_table :ciaobox_user_profiles do |t|
      t.references :admin, index: true, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :username
      t.attachment :avatar
      t.timestamps null: false
    end
    add_index :ciaobox_user_profiles, :username, unique: :true
  end
end

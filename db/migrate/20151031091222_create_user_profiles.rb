class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.references :user, index: true, foreign_key: true, unique: :true
      t.string :first_name
      t.string :last_name
      t.attachment :avatar
      t.timestamps null: false
    end
  end
end

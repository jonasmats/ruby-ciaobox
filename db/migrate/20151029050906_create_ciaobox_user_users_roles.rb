class CreateCiaoboxUserUsersRoles < ActiveRecord::Migration
  def change
    create_table :ciaobox_user_users_roles do |t|
      t.references :admin, index: true, foreign_key: true
      t.references :role, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :ciaobox_user_users_roles, [:admin_id, :role_id]
  end
end

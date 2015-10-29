namespace :db do
  desc "Create default admin and super role"

  task default_admin_and_role: :environment do
    role = Role.create(name: "Super Admin", description: "Super Admin");

    role.permissions.create!(entity: "Role", settings: {
        index: 1,
        show: 1,
        create: 1,
        update: 1,
        destroy: 1,
    })

    # admin = User.new(username: "superadmin", email: "superadmin@km.com", password: "12345678", password_confirmation: "12345678", admin: true, role_id: role.id)
    # admin.save!
    # admin.confirm!
  end
end

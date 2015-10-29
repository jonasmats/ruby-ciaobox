namespace :db do
  desc "Fill existing roles with new permissions"

  task populate_perms: :environment do
    roles = Role.all.includes(:permissions)

    roles.each do |role|
      exist_perms = role.permissions.map(&:entity)

      Role::ALL_ENTITY.each do |entity|
        unless exist_perms.include? entity
          role.permissions.create(entity: entity, settings: {
            index: 0,
            show: 0,
            create: 0,
            update: 0,
            destroy: 0
          });
          puts "Update permissions for #{entity} of role #{role}"
        end
      end
    end
  end
end
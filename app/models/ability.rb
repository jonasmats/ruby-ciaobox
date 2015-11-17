class Ability
  include CanCan::Ability

  def initialize(admin)
    if admin.nil?
      return false
    else
      case admin.class.name
      when CiaoboxUser::Super.name
        can :manage, :all
      when CiaoboxUser::Company.name
        can :manage, :all
        cannot :manage, Role
      when CiaoboxUser::Employee.name
        can :manage, [User, Admin, User::Profile, CiaoboxUser::Profile]
        roles = admin.roles
        if roles.present?
          roles.each do |role|
            role.permissions.each do |permission|
              can :index, permission.entity if permission.settings['index'] == '1'
              can :show, permission.entity if permission.settings['show'] == '1'
              can :create, permission.entity if permission.settings['create'] == '1'
              can :update, permission.entity if permission.settings['update'] == '1'
              can :destroy, permission.entity if permission.settings['destroy'] == '1'
            end
          end
        end
      end
    end
  end
end

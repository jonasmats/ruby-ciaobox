class Admin::RolesController < Admin::BaseAdminController
  include Admin::Roles::Parameter
  include Admin::Roles::Finder

  before_action :load_instance, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]

  def index
    # authorize! :index, "Role"
    @roles = load_roles
  end

  def new
    Role::ALL_ENTITY.each do |entity|
      @role.permissions.find_or_initialize_by entity: entity
    end
  end

  def create
    # authorize! :create, "Role"
    if @role.save
      redirect_to admin_roles_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    # authorize! :update, "Role"
    if @role.save
      redirect_to admin_roles_path
    else
      render :edit
    end
  end

  def destroy
    # authorize! :destroy, "Role"
    @role.destroy
    redirect_to admin_roles_path
  end

  private
  def load_instance
    @role = Role.find params[:id]
  end

  def create_instance
    @role = Role.new
  end

  def set_params
    @role.assign_attributes default_create_params
  end
end

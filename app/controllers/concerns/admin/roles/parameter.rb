module Admin::Roles::Parameter
  extend ActiveSupport::Concern

  private

  def default_create_params
    if params[:role]
      params.require(:role).permit(:name, :description,
        {
          permissions_attributes: [:id, :role_id, :entity,
          {
            settings: [:index, :show, :create, :update, :destroy]
          }]
        })
    end
  end
end

class Admin::UsersController < Admin::BaseAdminController
  authorize_resource class: User
  include ::Admin::Users::Parameter

  before_action :load_instance, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]

  def index
    @q = User.all.ransack(params[:q])
    @users = @q.result.latest
    respond_to do |format|
      format.html
      format.csv { send_data Export.users_to_csv(@users), filename: "Ciaobox_Users_#{Time.current}.csv" }
      format.xls { send_data Export.users_to_csv(@users, col_sep: "\t"), filename: "Ciaobox_Users_#{Time.current}.xls" }
    end
  end

  def show
  end

  def new
    @user.build_profile
  end

  def create
    if @user.save
      data = private_params.tap { |hs| hs.delete('password') }
      LogActionsJob.perform_later({
          owner_id: current_admin.id,
          action_type: params[:action],
          data: data
        }, @user)
      redirect_to admin_user_path(@user), notice: t('notice.admin.created', model: User.human_name)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.save
      data = private_params.tap { |hs| hs.delete('password') }
      LogActionsJob.perform_later({
          owner_id: current_admin.id,
          action_type: params[:action],
          data: data
        }, @user)
      respond_to do |format|
        format.html { redirect_to admin_user_path(@user), notice: t('notice.admin.updated', model: User.human_name) }
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    msg =
      if @user.destroy
        LogActionsJob.perform_later({
            owner_id: current_admin.id,
            action_type: params[:action],
            data: params.extract!(:id)
          }, @user)
        t('notice.admin.users.destroy.success')
      else
        t('notice.admin.users.destroy.error')
      end
    redirect_to admin_users_path, notice: msg
  end

  private
  def load_instance
    @user = ::User.find(params[:id])
  end

  def create_instance
    @user = User.new
  end

  def set_params
    @user.assign_attributes private_params
  end
end

class Admin::UsersController < Admin::BaseAdminController
  include ::Admin::Users::Parameter

  before_action :load_instance, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]

  def index
    @users = User.all.latest.includes(:profile)
    @q = @users.ransack(params[:q])
    @users = @q.result
    respond_to do |format|
      format.html
      format.csv { send_data Export.users_to_csv(@users), filename: "Ciaobox_Users_#{Time.current}.csv" }
      format.xls # { filename: "Ciaobox_Users_#{Time.current}.xls" }
    end
  end

  def show
  end

  def new
    @user.build_profile
  end

  def create
    if @user.save
      redirect_to admin_user_path(@user), notice: "Create employee user sucessfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.save
      redirect_to admin_user_path(@user), notice: "Update employee user sucessfully"
    else
      render :edit
    end
  end

  def destroy
    msg = 
      if @user.destroy
        "Destroy employee user sucessfully"
      else
        "Destroy employee user error"
      end
    redirect_to admin_users_path, notice: msg
  end

  private
  def load_instance
    @user = User.find(params[:id])
  end

  def create_instance
    @user = User.new
  end

  def set_params
    @user.assign_attributes private_params
  end
end

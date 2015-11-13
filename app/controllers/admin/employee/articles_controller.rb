class Admin::Employee::ArticlesController < Admin::BaseAdminController
  authorize_resource class: Article
  include ::Admin::Articles::Parameter

  before_action :load_article, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]

  def index
    @articles =
      if Article.statuses.keys.include? params[:type]
        Article.article_status(params[:type]).includes(:admin, :translations)
      else
        Article.all.includes(:admin, :translations)
      end
  end

  def show
  end

  def new
  end
  def create
    if @article.save
      redirect_to admin_employee_article_path(@article), notice: t('notice.admin.created', model: Article.human_name)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.save
      respond_to do |format|
        format.html { redirect_to admin_employee_article_path(@article), notice: t('notice.admin.updated', model: Article.human_name)}
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    msg =
      if @article.destroy
        t('notice.admin.admins.destroy.success')
      else
        t('notice.admin.admins.destroy.error')
      end
    redirect_to admin_employee_articles_path, notice: msg
  end

  private
  def load_article
    @article = Article.find(params[:id])
  end

  def create_instance
    @article = current_admin.articles.new
  end

  def set_params
    @article.assign_attributes private_params
  end
end

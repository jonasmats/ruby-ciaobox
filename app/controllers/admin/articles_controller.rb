class Admin::ArticlesController < Admin::BaseAdminController
  include ::Admin::Articles::Parameter

  before_action :load_article, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]

  def index
    @articles =
      if Article.statuses.keys.include? params[:type]
        Article.article_status params[:type]
      else
        Article.all
      end
  end

  def show
  end

  def new
  end

  def create
    if @article.save
      redirect_to admin_article_path(@article), notice: t('admin.admins.update.success') and return
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.save
      redirect_to admin_article_path(@article), notice: t('admin.admins.update.success') and return
    else
      render :edit
    end
  end

  def destroy
    msg =
      if @article.destroy
        t('admin.admins.destroy.success')
      else
        t('admin.admins.destroy.error')
      end
    redirect_to admin_articles_path, notice: msg
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

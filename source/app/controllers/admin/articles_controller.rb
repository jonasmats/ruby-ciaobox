class Admin::ArticlesController < Admin::BaseAdminController
  include ::Admin::Article::Parameter

  before_action :load_article, except: [:index, :new, :create]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def load_article
    @article = Article.find(params[:id])
  end
end

class Admin::ArticlesController < Admin::BaseAdminController
  include ::Admin::Articles::Parameter

  before_action :load_article, except: [:index, :new, :create]

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
  end

  def edit
  end

  def update
  end

  def destroy
    msg = 
      if @article.destroy
        "Destroy article successfully"
      else
        "Destroy article error"
      end
    redirect_to admin_articles_path, notice: msg
  end

  private
  def load_article
    @article = Article.find(params[:id])
  end
end

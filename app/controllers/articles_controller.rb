class ArticlesController < ApplicationController
  layout "application.blog"

  def index
    @articles = Article.live.newest.includes(:admin, :translations).page(params[:page]).per(Settings.per_page.blog)
  end

  def show
    @article = Article.find(params[:id])
  end
end

class ArticlesController < ApplicationController
  layout "application.blog"

  def index
    @articles = Article.live.includes(:admin, :translations)
  end

  def show
    @article = Article.find(params[:id])
  end
end

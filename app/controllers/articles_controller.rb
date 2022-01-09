class ArticlesController < ApplicationController

  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new
  end

  def create
    article_params = params.require(:article).permit(:title, :description)
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

end

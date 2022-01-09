class ArticlesController < ApplicationController

  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    article_params = params.require(:article).permit(:title, :description)
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: "Article was successfully created."
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    article_params = params.require(:article).permit(:title, :description)
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, notice: "Article was successfully updated."
    else
      render 'edit'
    end
  end

end

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_prev_page, only: [:edit]
  before_action :require_login, except: [:index, :show]
  before_action :require_same_user_or_admin, only: [:edit, :update, :destroy]

  def index
    if request.query_parameters[:categories].present?
      category_names = request.query_parameters[:categories].split(',')
      @articles = articles_with_categories(category_names)
    end
    @articles = Article.all if @articles.nil? || @articles.empty?
    @articles = @articles.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to @article, notice: "Article was successfully created."
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Article was successfully updated."
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: "Article was successfully deleted."
  end

  private 

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def set_prev_page
    @prev_page = request.referer || articles_path
  end

  def require_same_user_or_admin
    if current_user != @article.user && !current_user.admin?
      redirect_to @article, alert: "You are not authorized to edit or delete this article."
    end
  end

  def articles_with_categories(category_names)
    category_ids = Category.where(name: category_names).pluck(:id)
    article_ids = ArticleCategory.where(category_id: category_ids).pluck(:article_id)
    @articles = Article.where(id: article_ids)
  end

end

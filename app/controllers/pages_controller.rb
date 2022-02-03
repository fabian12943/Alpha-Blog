class PagesController < ApplicationController
  @@AMOUNT_OF_ARTICLES = 4

  def home
    redirect_to articles_path if logged_in?
    @articles = Article.order(created_at: :desc).limit(@@AMOUNT_OF_ARTICLES)
  end

end

class PagesController < ApplicationController
  @@AMOUNT_OF_ARTICLES = 6

  def home
    @articles = Article.order(created_at: :desc).limit(@@AMOUNT_OF_ARTICLES)
  end

end

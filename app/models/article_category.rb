class ArticleCategory < ApplicationRecord
  belongs_to :article
  belongs_to :category

  def self.most_used_categories(amount_of_categories)
    ArticleCategory.select('category_id, count(category_id) as article_count')
                   .group('category_id')
                   .order('article_count DESC')
                   .limit(amount_of_categories)
                   .map { |article_category| article_category.category }
  end
end
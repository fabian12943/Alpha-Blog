class Category < ApplicationRecord
  PAGE_LIMIT = 12

  has_many :article_categories, dependent: :destroy
  has_many :articles, through: :article_categories, dependent: :destroy

  before_validation { self.tag_color.sub!(/^#/, '') }

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 15 }
  validates :tag_color, presence: true, length: { minimum: 6, maximum: 6 }

end
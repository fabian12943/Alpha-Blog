class Category < ApplicationRecord
  PAGE_LIMIT = 12

  has_one_attached :image, dependent: :destroy
  has_many :article_categories, dependent: :destroy
  has_many :articles, through: :article_categories, dependent: :destroy

  before_validation { self.tag_color.sub!(/^#/, '') }

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 2, maximum: 15 }
  validates :tag_color, presence: true, length: { minimum: 6, maximum: 6 }
  validates :image, blob: { content_type: ['image/jpg', 'image/jpeg', 'image/png'], size_range: 0..3.megabytes }

end
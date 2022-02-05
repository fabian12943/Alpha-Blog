class Article < ApplicationRecord
  belongs_to :user

  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories, dependent: :destroy
  
  validates :title, presence: true, length: { minimum: 5, maximum: 120 }
  validates :description, presence: true, length: { minimum: 10, maximum: 10000 }
  validates :category_ids , length: { minimum: 0, maximum: 5 }
end
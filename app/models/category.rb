class Category < ApplicationRecord
  PAGE_LIMIT = 12
  has_and_belongs_to_many :articles

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 15 }
end
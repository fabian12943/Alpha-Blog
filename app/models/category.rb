class Category < ApplicationRecord
  PAGE_LIMIT = 12

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 15 }
end
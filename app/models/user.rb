class User < ApplicationRecord
  has_many :articles, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 2, maximum: 25 }
  validates :first_name, presence: true, length: { minimum: 2, maximum: 25 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 25 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true, length: { maximum: 100 }

end
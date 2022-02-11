class User < ApplicationRecord
  PAGE_LIMIT = 12
  PAGE_LIMIT_ARTICLES = 10
  
  has_many :articles, dependent: :destroy

  has_secure_password

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 2, maximum: 25 }
  validates :first_name, presence: true, length: { minimum: 2, maximum: 25 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 25 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true, length: { maximum: 100 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: false

  before_save { self.email.downcase! }
  before_save { self.first_name.downcase! }
  before_save { self.last_name.downcase! }

  def fullname
    "#{first_name.titleize} #{last_name.titleize}"
  end
end
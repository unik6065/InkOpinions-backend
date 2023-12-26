class User < ApplicationRecord
  has_secure_password

  has_many :book_reviews

  validates :username, presence: true
  validates :email, presence: true
  validates :age, presence: true
end

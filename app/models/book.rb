class Book < ApplicationRecord
  has_many :book_reviews, dependent: :destroy

  validates :name, presence: true
  validates :weight, presence: true
end

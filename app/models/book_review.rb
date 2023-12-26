class BookReview < ApplicationRecord
  has_one :user
  has_one :book

  validates :grade, presence: true
  validates :grade, numericality: { greater_than: 0, less_than: 6 }
  validates :user_id, presence: true
  validates :book_id, presence: true
end

class Book < ApplicationRecord
  validates :name, presence: true
  validates :weight, presence: true
end

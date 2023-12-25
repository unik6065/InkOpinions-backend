class CreateBookReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :book_reviews do |t|
      t.integer :grade
      t.text :review
      t.belongs_to :user
      t.belongs_to :book
      t.timestamps
    end
  end
end

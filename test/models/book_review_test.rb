require 'test_helper'

class BookReviewTest < ActiveSupport::TestCase
  def setup
    @lotr_review = BookReview.new(grade: 5, review: 'best book ever', user_id: users(:test_user).id,
                                  book_id: books(:lotr).id)
  end

  test 'a Book Review must be saved if everything is fine' do
    assert @lotr_review.valid?
  end

  test 'a Book Review must not be saved if there is no user' do
    @lotr_review.user_id = nil
    assert_not @lotr_review.valid?
  end

  test 'a Book review must not be saved if there is no book' do
    @lotr_review.book_id = nil
    assert_not @lotr_review.valid?
  end

  test 'a Book review must have a grade' do
    @lotr_review.grade = nil
    assert_not @lotr_review.valid?
  end

  test 'a grade must smaller than 5' do
    @lotr_review.grade = 6
    assert_not @lotr_review.valid?
  end

  test 'a grade must be greater than 0' do
    @lotr_review.grade = 0
    assert_not @lotr_review.valid?
  end
end

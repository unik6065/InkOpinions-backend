require 'test_helper'

class BookReviewsControllerTest < ActionDispatch::IntegrationTest
  def setup
    user_infos = { user_id: 1 }
    @jwt_token = JWT.encode(user_infos, Rails.application.credentials.secret_key_base, 'HS256')
  end

  test 'should create book review' do
    post book_review_url, params: { book_review: { book_id: 1, rating: 5, comment: 'This is a good book.' } },
                          headers: { 'Authorization' => @jwt_token }
    assert_response :success
    assert_equal 'This is a good book.', BookReview.last.comment
  end

  test 'should not create book review if user is not logged in' do
    post book_review_url, params: { book_review: { book_id: 1, rating: 5, comment: 'This is a good book.' } }
    assert_response :unauthorized
    assert_equal 'Please log in', JSON.parse(@response.body)['message']
  end

  test 'should update book review' do
    put book_review_url(1), params: { book_review: { rating: 4, comment: 'This is a good book.' } },
                            headers: { 'Authorization' => @jwt_token }
    assert_response :success
    assert_equal 4, BookReview.find(1).rating
  end

  test 'should not update book review if user is not logged in' do
    put book_review_url(1), params: { book_review: { rating: 4, comment: 'This is a good book.' } }
    assert_response :unauthorized
    assert_equal 'You are not authorized to perform this action.', JSON.parse(@response.body)['message']
  end

  test 'should not update book review that are not created by the user' do
    put book_review_url(2), params: { book_review: { rating: 4, comment: 'This is a good book.' } },
                            headers: { 'Authorization' => @jwt_token }
    assert_response :unauthorized
    assert_equal 'You are not authorized to perform this action.',
                 JSON.parse(@response.body)['message']
  end

  test 'should destroy book review' do
    delete book_review_url(1), headers: { 'Authorization' => @jwt_token }
    assert_response :success
    assert_nil BookReview.find_by(id: 1)
  end

  test 'should not destroy book review if user is not logged in' do
    delete book_review_url(1)
    assert_response :unauthorized
    assert_equal 'Please log in', JSON.parse(@response.body)['message']
  end

  test 'should not destroy book review that are not created by the user' do
    delete book_review_url(2), headers: { 'Authorization' => @jwt_token }
    assert_response :unauthorized
    assert_equal 'You are not authorized to perform this action.', JSON.parse(@response.body)['message']
  end
end

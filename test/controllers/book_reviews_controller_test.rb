require 'test_helper'

class BookReviewsControllerTest < ActionDispatch::IntegrationTest
  def setup
    user_infos = { user_id: 1 }
    @jwt_token = JWT.encode(user_infos, Rails.application.credentials.secret_key_base, 'HS256')
  end

  test 'should create book review' do
    post '/book_review', params: { book_review: { grade: 5, review: 'This is a good book.' } },
                         headers: { 'Authorization' => "Bearer #{@jwt_token}" }
    assert_response :success
    assert_equal 5, JSON.parse(@response.body)['message']['grade']
  end

  test 'should not create book review if user is not logged in' do
    post '/book_review', params: { book_review: { grade: 5, review: 'This is a good book.' } }
    assert_response :unauthorized
    assert_equal 'Please log in', JSON.parse(@response.body)['message']
  end

  test 'should update book review' do
    put book_review_url(book_reviews(:one)), params: { book_review: { grade: 4, review: 'This is a good book.' } },
                                             headers: { 'Authorization' => "Bearer #{@jwt_token}" }
    assert_response :success
    assert_equal 4, BookReview.find(book_reviews(:one).id).grade
  end

  test 'should not update book review if user is not logged in' do
    put book_review_url(book_reviews(:one)), params: { book_review: { grade: 4, review: 'This is a good book.' } }
    assert_response :unauthorized
    assert_equal 'Please log in', JSON.parse(@response.body)['message']
  end

  test 'should not update book review that are not created by the user' do
    put book_review_url(book_reviews(:two)), params: { book_review: { grade: 4, review: 'This is a good book.' } },
                                             headers: { 'Authorization' => "Bearer #{@jwt_token}" }
    assert_response :unauthorized
    assert_equal 'You are not authorized to perform this action.',
                 JSON.parse(@response.body)['message']
  end

  test 'should destroy book review' do
    delete book_review_url(book_reviews(:one)), headers: { 'Authorization' => "Bearer #{@jwt_token}" }
    assert_response :success
    assert_nil BookReview.find_by(id: 1)
  end

  test 'should not destroy book review if user is not logged in' do
    delete book_review_url(book_reviews(:one))
    assert_response :unauthorized
    assert_equal 'Please log in', JSON.parse(@response.body)['message']
  end

  test 'should not destroy book review that are not created by the user' do
    delete book_review_url(book_reviews(:two)), headers: { 'Authorization' => "Bearer #{@jwt_token}" }
    assert_response :unauthorized
    assert_equal 'You are not authorized to perform this action.', JSON.parse(@response.body)['message']
  end
end

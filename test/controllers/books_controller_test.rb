require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  def setup
    user_infos = { user_id: 1 }
    @jwt_token = JWT.encode(user_infos, Rails.application.credentials.secret_key_base, 'HS256')
  end
  test 'should get index' do
    get '/book'
    assert_response :success
    assert_equal @response.body.include?('books'), true
    assert_equal @response.body['books'].length.positive?, true
  end

  test 'should get show' do
    get "/book/#{books(:lotr).id}"
    assert_response :success
    assert_equal @response.body.include?('book'), true
    assert_equal books(:lotr)['name'], JSON.parse(@response.body)['book']['name']
  end

  test 'should get create' do
    post '/book', params: { name: 'The Hobbit', description: 'lorem ipsum' },
                  headers: { Authorization: "Bearer #{@jwt_token}" }
    assert_response :success
    assert_equal @response.body.include?('book'), true
    assert_equal 'The Hobbit', JSON.parse(@response.body)['book']['name']
  end

  test 'should not get create if not logged in' do
    post '/book', params: { name: 'The Hobbit', description: 'lorem ipsum' }
    assert_response :unauthorized
  end

  test 'should get update' do
    put "/book/#{books(:lotr).id}", params: { name: 'The Hobbit', description: 'lorem ipsum' },
                                    headers: { Authorization: "Bearer #{@jwt_token}" }
    assert_response :success
    assert_equal @response.body.include?('book'), true
    assert_equal 'The Hobbit', JSON.parse(@response.body)['book']['name']
  end

  test 'should not get update if not logged in' do
    put "/book/#{books(:lotr).id}", params: { name: 'The Hobbit', description: 'lorem ipsum' }
    assert_response :unauthorized
  end

  test 'should get destroy' do
    delete "/book/#{books(:lotr).id}", headers: { Authorization: "Bearer #{@jwt_token}" }
    assert_response :success
    assert_equal @response.body.include?('book'), true
    assert_equal books(:lotr)['name'], JSON.parse(@response.body)['book']['name']
  end

  test 'should not get destroy if not logged in' do
    delete "/book/#{books(:lotr).id}"
    assert_response :unauthorized
  end
end

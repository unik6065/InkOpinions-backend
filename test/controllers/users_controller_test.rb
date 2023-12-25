require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should create a user when ask for it' do
    post '/user', params: { username: 'john', password: 'test', age: 23, email: 'john@doe.com' }
    assert_response :success
    assert_equal 'john', JSON.parse(@response.body)['user']['username']
  end

  test 'should not create a user if not all params are fulfilled' do
    post '/user', params: { username: 'john' }
    assert_equal 'Can not Create the User', JSON.parse(@response.body)['error']
  end
end

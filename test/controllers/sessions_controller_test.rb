require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should return user info when login' do
    post '/login', params: { username: 'test', password: 'test' }
    assert_response :success
    assert_equal 'test', JSON.parse(@response.body)['user']['username']
  end

  test 'should return user info when auto_login with user credentials' do
    user_infos = { user_id: 1 }
    jwt_token = JWT.encode(user_infos, Rails.application.credentials.secret_key_base, 'HS256')

    get '/auto_login', headers: { Authorization: "Bearer #{jwt_token}" }

    assert_response :success
    assert_equal 'test', JSON.parse(@response.body)['username']
  end
end

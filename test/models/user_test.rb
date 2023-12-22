require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'the truth' do
    assert true
  end

  test 'should not save user without email' do
    user = User.new(age: 20, username: 'test', password: 'test')
    assert_not user.save
  end

  test 'should not save user without age' do
    user = User.new(email: 'test@gmail.com', username: 'test', password: 'test')
    assert_not user.save
  end

  test 'should not save user without username' do
    user = User.new(email: 'test@gmail.com', age: 20, password: 'test')
    assert_not user.save
  end

  test 'should not save user without password' do
    user = User.new(email: 'test@gmail.com', age: 20, username: 'test')
    assert_not user.save
  end
end

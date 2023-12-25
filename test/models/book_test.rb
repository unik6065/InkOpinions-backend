require 'test_helper'

class BookTest < ActiveSupport::TestCase
  def setup
    @book = Book.new(name: 'lotr', description: 'Lorem.ipsum', weight: 25)
  end

  test 'should not create a book if name is nil' do
    @book.name = nil
    assert_not @book.valid?
  end

  test 'should not create a book if weight is nil' do
    @book.weight = nil
    assert_not @book.valid?
  end

  test 'should create a book if everything is fulfilled' do
    assert @book.valid?
  end
end

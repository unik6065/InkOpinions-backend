class BooksController < ApplicationController
  skip_before_action :authorized, only: %i[index show]

  def index
    render json: { books: Book.all }
  end

  def show
    render json: { book: Book.find(params[:id]) }
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    render json: { book: }
  end

  def create
    book = Book.create(book_params)
    render json: { book: }
  end

  def destroy
    book = Book.find(params[:id])
    book&.destroy
    render json: { book: }
  end

  private

  def book_params
    params.permit(:name, :description)
  end
end

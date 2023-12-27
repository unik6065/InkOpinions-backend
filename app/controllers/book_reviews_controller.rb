class BookReviewsController < ApplicationController
  def create
    @book_review = BookReview.new(book_review_params)
    @book_review.user = @current_user
    if @book_review.save
      render json: { error: 'Book review not created' }, status: :unprocessable_entity
    else
      render json: { message: @book_review }, status: :created
    end
  end

  def update
    @book_review = BookReview.find(params[:id])
    if @book_review.user != @current_user
      return render json: { message: 'You are not authorized to perform this action.' },
                    status: :unauthorized
    end
    if @book_review.update(book_review_params)
      render json: { message: @book_review }, status: :ok
    else
      render json: { error: 'Book review not updated' }, status: :unprocessable_entity
    end
  end

  def destroy
    @book_review = BookReview.find(params[:id])
    if @book_review.user != @current_user
      return render json: { message: 'You are not authorized to perform this action.' },
                    status: :unauthorized
    end
    if @book_review.destroy
      render json: { message: 'Book review deleted' }, status: :ok
    else
      render json: { error: 'Book review not deleted' }, status: :unprocessable_entity
    end
  end

  private

  def book_review_params
    params.require(:book_review).permit(:grade, :review, :book)
  end
end

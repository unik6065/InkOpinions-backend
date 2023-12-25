class UsersController < ApplicationController
  # Register
  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: }
    else
      render json: { error: 'Can not Create the User' }
    end
  end

  private

  def user_params
    params.permit(:username, :password, :age, :email)
  end
end

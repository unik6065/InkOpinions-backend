class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:create]

  # LOGGING IN
  def create
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def auto_login
    render json: @user
  end
end

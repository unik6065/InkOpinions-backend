class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:create]

  # LOGGING IN
  def create
    @current_user = User.find_by(username: params[:username])

    if @current_user && @current_user.authenticate(params[:password])
      token = encode_token({ user_id: @current_user.id })
      render json: { user: @current_user, token: }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def auto_login
    render json: @current_user
  end
end

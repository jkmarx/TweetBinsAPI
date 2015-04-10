require Rails.root.join('lib/modules/OAuth')
class UsersController < ApplicationController
  before_filter :authenticate, only: [:logout, :show, :update]
  before_action :set_user, only: [:show, :update, :destroy]

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      render json: { token: @user.token, email: @user.email }
    else
      head :unauthorized
    end
  end

  def logout
    @user.update(accessToken: "", tokenSecret: "")
    head :ok
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render json: @user, status: 200
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    byebug;
    if @user.save
      render json: {token: @user.token, twitterUsername: @user.twitterUsername}, status: :created
    else
      render json: {message: 'failed'}, status: 500
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      render json: {token: @user.token, twitterUsername: @user.twitterUsername}, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    head :no_content
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:twitterUsername, :email,:password, :token, :accessToken, :tokenSecret)
    end
end

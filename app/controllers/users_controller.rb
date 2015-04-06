class UsersController < ApplicationController
  before_filter :authenticate, only: [:show, :update]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  # GET /users.json
  # def index
  #   @users = User.all
  #   render json: @users, status: 200
  # end

  def getAccess
    @user = User.find_by(:twitterUsername)
    if @user && @user.authenticate(params[:twitterUserId])
      render json: { appToken: @user.appToken, @user.twitterUsername }
    else
      head :unauthorized
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

    if @user.save
      render json: {appToken: @user.token, twitterUsername: @user.twitterUsername}, status: :created, location: @user
    else
      render json: {message: 'failed'}, status: 500
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      render json: {appToken: @user.token, twitterUsername: @user.twitterUsername}, status: :ok
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
      params.require(:user).permit(:twitterUsername, :twitterUserId, :appToken, :accessToken, :tokenSecret)
    end
end

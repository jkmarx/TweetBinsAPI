class UserAuthenticationsController < ApplicationController
  before_action :set_user_authentication, only: [:show, :update, :destroy]

  # GET /user_authentications
  # GET /user_authentications.json
  def index
    @user_authentications = UserAuthentication.all

    render json: @user_authentications
  end

  # GET /user_authentications/1
  # GET /user_authentications/1.json
  def show
    render json: @user_authentication
  end

  # POST /user_authentications
  # POST /user_authentications.json
  def create
    @user_authentication = UserAuthentication.new(user_authentication_params)

    if @user_authentication.save
      render json: @user_authentication, status: :created, location: @user_authentication
    else
      render json: @user_authentication.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_authentications/1
  # PATCH/PUT /user_authentications/1.json
  def update
    @user_authentication = UserAuthentication.find(params[:id])

    if @user_authentication.update(user_authentication_params)
      head :no_content
    else
      render json: @user_authentication.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_authentications/1
  # DELETE /user_authentications/1.json
  def destroy
    @user_authentication.destroy

    head :no_content
  end

  private

    def set_user_authentication
      @user_authentication = UserAuthentication.find(params[:id])
    end

    def user_authentication_params
      params.require(:user_authentication).permit(:user_id, :token, :token_expires_at)
    end
end

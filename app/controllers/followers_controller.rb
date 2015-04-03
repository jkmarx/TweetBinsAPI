class FollowersController < ApplicationController
  before_action :set_follower, only: [:show, :update, :destroy]

  # GET /followers
  # GET /followers.json
  def index
    @followers = Follower.all

    render json: @followers
  end

  # GET /followers/1
  # GET /followers/1.json
  def show
    render json: @follower
  end

  # POST /followers
  # POST /followers.json
  def create
    @follower = Follower.new(follower_params)

    if @follower.save
      render json: @follower, status: :created, location: @follower
    else
      render json: @follower.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /followers/1
  # PATCH/PUT /followers/1.json
  def update
    @follower = Follower.find(params[:id])

    if @follower.update(follower_params)
      head :no_content
    else
      render json: @follower.errors, status: :unprocessable_entity
    end
  end

  # DELETE /followers/1
  # DELETE /followers/1.json
  def destroy
    @follower.destroy

    head :no_content
  end

  private

    def set_follower
      @follower = Follower.find(params[:id])
    end

    def follower_params
      params.require(:follower).permit(:twitterHandle, :category_id)
    end
end

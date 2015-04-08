require Rails.root.join('lib/modules/TweetAuth')
class FollowersController < ApplicationController
  before_action :set_follower, only: [:show, :update, :destroy]
   before_filter :authenticate, only: [ :index]
  # GET /followers
  # GET /followers.json
  def index
    @user = User.first
    followers = Rails.cache.read(@user.token + "_followers")
    if followers
      render json: followers, status: 200
    else
      @request = TweetAuth::AuthHeader.new(get_token())
      response = @request.request_data(TweetAuth::get_header_string(get_tokenSecret(), @request.params, "followers"),TweetAuth::get_base_url("followers"),"GET")
      if !(response.body.include? "errors")
        followerIds = Follower.filterTweets(response.body).to_json
        Rails.cache.write(@user.token + "followers", followerIds)
        render json: followerIds, status: 200
      else
        render json: response, status: 401
      end
    end
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

     private

    def get_token()
      @user.accessToken.split('=')[1]
     # User.first.accessToken.split('=')[1]
    end

    def get_tokenSecret()
      @user.tokenSecret.split('=')[1]
     # User.first.tokenSecret.split('=')[1]
    end
end

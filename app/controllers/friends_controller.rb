require Rails.root.join('lib/modules/TweetAuth')
class FriendsController < ApplicationController
  before_action :set_friend, only: [:show, :update]
   before_filter :authenticate, only: [ :index]
  # GET /friends
  # GET /friends.json
  def index
    @user = User.first
    friends = Rails.cache.read(@user.token + "_friends")
    if friends
      render json: friends, status: 200
    else
      @request = TweetAuth::AuthHeader.new(get_token())
      response = @request.request_data(TweetAuth::get_header_string(get_tokenSecret(), @request.params, "friends"),TweetAuth::get_base_url("friends"),"GET")
      if !(response.body.include? "errors")
        friendIds = Friend.filterTweets(response.body).to_json
        Rails.cache.write(@user.token + "friends", friendIds)
        render json: friendIds, status: 200
      else
        render json: response, status: 401
      end
    end
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
    render json: @friend
  end

  # POST /friends
  # POST /friends.json
  def create
    @friend = Friend.new(friend_params)
    if @friend.save
      render json: @friend, status: :created, location: @friend
    else
      render json: @friend.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /friends/1
  # PATCH/PUT /friends/1.json
  def update
    @friend = Friend.find(params[:id])

    if params[:category_id]
      @category = Category.find(params[:category_id])
      unless @category.friends.include? @friend
        @category.friends << @friend
      end
      render json: @category.friends, status: :ok
    else
      if @friend.update(friend_params)
        head :no_content
      else
        render json: @friend.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /friends/1
  # DELETE /friends/1.json
  def destroy
    @friend = Friend.find_by twitterId: (params[:twitterId])
    @friend.destroy

    head :no_content
  end

  private

    def set_friend
      @friend = Friend.find(params[:id])
    end

    def friend_params
      params.require(:friend).permit(:twitterId, :category_id)
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

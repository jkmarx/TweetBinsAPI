class SaveTweetsController < ApplicationController
  before_filter :authenticate, only: [:index, :create, :destroy]
  before_action :set_save_tweet, only: [ :destroy]

  # GET /fave_tweets
  # GET /fave_tweets.json
  def index
    @save_tweets = SaveTweet.all
    render json: @save_tweets, status: 200
  end

  # POST /fave_tweets
  # POST /fave_tweets.json
  def create
    @save_tweet = SaveTweet.new(save_tweet_params)
    @save_tweet.user_id = @user.id

    if @save_tweet.save
      render json: @save_tweet, status: :created, location: @save_tweet
    else
      render json: @save_tweet.errors, status: :unprocessable_entity
    end
  end


  # DELETE /fave_tweets/1
  # DELETE /fave_tweets/1.json
  def destroy
    @save_tweet.destroy

    head :no_content
  end

  private

    def set_save_tweet
      @save_tweet = SaveTweet.find(params[:id])
    end

    def save_tweet_params
      params.require(:save_tweet).permit(:userScreenname, :text, :userId, :created_at, :user_id, :profile_image_url)
    end
end

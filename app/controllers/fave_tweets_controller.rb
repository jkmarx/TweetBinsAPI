class FaveTweetsController < ApplicationController
  before_filter :authenticate, only: [:index, :create, :destroy]
  before_action :set_fave_tweet, only: [ :destroy]

  # GET /fave_tweets
  # GET /fave_tweets.json
  def index
    @fave_tweets = FaveTweet.all

    render json: @fave_tweets
  end

  # POST /fave_tweets
  # POST /fave_tweets.json
  def create
    @fave_tweet = FaveTweet.new(fave_tweet_params)
    @fave_tweet.user_id = @user.id

    if @fave_tweet.save
      render json: @fave_tweet, status: :created, location: @fave_tweet
    else
      render json: @fave_tweet.errors, status: :unprocessable_entity
    end
  end


  # DELETE /fave_tweets/1
  # DELETE /fave_tweets/1.json
  def destroy
    @fave_tweet.destroy

    head :no_content
  end

  private

    def set_fave_tweet
      @fave_tweet = FaveTweet.find(params[:id])
    end

    def fave_tweet_params
      params.require(:fave_tweet).permit(:userScreenname, :text, :userId, :user_id)
    end
end

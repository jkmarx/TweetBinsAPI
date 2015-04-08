require "#{Rails.root}/lib/modules/TweetAuth.rb"
class TweetsController < ApplicationController
  # before_filter :authenticate, only: [ :show, :create, :destroy]

  def index
    user = authenticate()
    token = user.accessToken.split('=')[1]
    tokenSecret = user.tokenSecret.split('=')[1]
    @request = TweetAuth::AuthHeader.new(token)

    response = @request.request_data(TweetAuth::get_header_string(tokenSecret, @request.params),TweetAuth::get_base_url(),"GET")
    if response.body
      outTweets = Tweet.filterTweets(JSON.parse(response.body)).to_json

      render json: outTweets, status: 200
    else
      render status: 401
    end

  end

end


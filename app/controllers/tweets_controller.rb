require Rails.root.join('lib/modules/TweetAuth')
class TweetsController < ApplicationController
   before_filter :authenticate, only: [ :index]

  def index
    tweets = Rails.cache.read(@user.token + "_tweets")
    if tweets
      render json: tweets, status: 200
    else
      @request = TweetAuth::AuthHeader.new(get_token())
      response = @request.request_data(TweetAuth::get_header_string(get_tokenSecret(), @request.params, "tweets"),TweetAuth::get_base_url("tweets"),"GET")

      if !(response.body.include? "errors")
        outTweets = Tweet.filterTweets(response.body).to_json
        Rails.cache.write(User.first.token + "_tweets", outTweets)
        render json: outTweets, status: 200
      else
        render status: 401
      end
    end

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


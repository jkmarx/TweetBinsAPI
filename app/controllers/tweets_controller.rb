require Rails.root.join('lib/modules/TweetAuth')
class TweetsController < ApplicationController
   before_filter :authenticate, only: [ :index]

  def index
    tweets = Rails.cache.read(@user.token + "_tweetsJ")
    if tweets
      render json: tweets, status: 200, root: false
    else
      @request = TweetAuth::AuthHeader.new(get_token())
      response = @request.request_data(TweetAuth::get_header_string(get_tokenSecret(), @request.params, "tweets", "count%3D200%26"),TweetAuth::get_base_url("tweets"),"GET", "?count=200")
      if (response.body.include? "200")
        outTweets = Tweet.filterTweets(response.body).to_json
        Rails.cache.write(User.first.token + "_tweetsJ", outTweets, {expires_in: 15.minutes})
        render json: outTweets, status: 200, root: false
      else
        render json: response, status: 401
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

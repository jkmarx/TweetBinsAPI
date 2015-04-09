require Rails.root.join('lib/modules/TweetAuth')
class TweetsController < ApplicationController
   before_filter :authenticate, only: [ :index]

  def index
    tweets = Rails.cache.read(@user.token + "_tweetsJ")
    if tweets
      render json: tweets, status: 200
    else
      @request = TweetAuth::AuthHeader.new(get_token())
      response = @request.request_data(TweetAuth::get_header_string(get_tokenSecret(), @request.params, "tweets", "count%3D200%26"),TweetAuth::get_base_url("tweets"),"GET", "?count=200")

      if !(response.body.include? "errors")
        outTweets = Tweet.filterTweets(response.body).to_json
        Rails.cache.write(User.first.token + "_tweetsJ", outTweets, {expires_in: 3.minutes})
        render json: outTweets, status: 200
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

# curl --get 'https://api.twitter.com/1.1/statuses/home_timeline.json' --data 'count=200' --header 'Authorization: OAuth oauth_consumer_key="fZcUdPbYdkEu64csHixN5dMjM", oauth_nonce="f3f24cf58d044d4ba46d8d3318420675", oauth_signature="Os4Mubg5k56FLYoFfOoJ0FK2uZA%3D", oauth_signature_method="HMAC-SHA1", oauth_timestamp="1428554817", oauth_token="2993886084-gXAyKxFEm8TjcKNFx0zVwD1b3UhPxeRqdSYRSBO", oauth_version="1.0"' --verbose

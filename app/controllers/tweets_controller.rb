require Rails.root.join('lib/modules/TweetAuth')
class TweetsController < ApplicationController
   before_filter :authenticate, only: [ :index]

  def index
    @request = TweetAuth::AuthHeader.new(get_token())
    response = @request.request_data(TweetAuth::get_header_string(get_tokenSecret(), @request.params),TweetAuth::get_base_url(),"GET")

    if !(response.body.include? "errors")
      outTweets = Tweet.filterTweets(response.body).to_json
      render json: outTweets, status: 200
    else
      render status: 401
    end

  end

  private

    def get_token()
      @user.accessToken.split('=')[1]
    end

    def get_tokenSecret()
      @user.tokenSecret.split('=')[1]
    end

end


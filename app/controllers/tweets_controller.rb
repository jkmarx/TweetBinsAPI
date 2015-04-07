require Rails.root.join('lib/modules/TweetAuth')

class TweetsController < ApplicationController
  before_filter :authenticate, only: [ :show, :create, :update, :destroy]

  def index
    user = authenticate()
    token = user.accessToken.split('=')[1]
    tokenSecret = user.tokenSecret.split('=')[1]
    @request = TweetAuth::AuthHeader.new(token)

    response = @request.request_data(TweetAuth::get_header_string(tokenSecret, @request.params),TweetAuth::get_base_url(),"GET")
    byebug;
    if response.body
      outTweets = filterTweets(JSON.parse(response.body)).to_json

      render json: outTweets, status: 200
    else
      render status: 401
    end

  end

  private

  def filterTweets(data)
    data.map{|tweet|
      {
        userScreen: getScreenname(tweet),
        text: getText(tweet),
        created_at: getCreatedAt(tweet)
      }
    }
  end

  def getScreenname(string)
    string["user"]["screen_name"]
  end

  def getText(string)
    string["text"]
  end

  def getCreatedAt(string)
    string["created_at"]
  end

end


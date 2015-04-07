require Rails.root.join('lib/modules/OAuth')
require Rails.root.join('lib/modules/Tweets')

class TweetsController < ApplicationController
  before_filter :authenticate, only: [ :show, :create, :update, :destroy]

  def index
    user = authenticate()
    fullpath = request.fullpath
    token = user.accessToken.split('=')[1]
    tokenSecret = user.tokenSecret.split('=')[1]
    @request = Tweets::AuthHeader.new(token, {params: user.tokenSecret})
    response = @request.request_data(Tweets::get_header_string(tokenSecret, @request.params),Tweets::get_base_url(),"GET")
    parse_text(data)
    if response.body
      render json: response.body, status: 200
    else
      render status: 401
    end
  end
end

private
def parse_text(data)
  data.map{ |tweet|

    byebug;
  }
end

# curl --get 'https://api.twitter.com/1.1/statuses/home_timeline.json' --header 'Authorization: OAuth oauth_consumer_key="B0QBJGLd6NeHMrOHATSm5luAF", oauth_nonce="5829855bdd534a5f8965e784d3d4c47f", oauth_signature="rUzwmThVvObGweLe%2BvqRIvAZf0Q%3D", oauth_signature_method="HMAC-SHA1", oauth_timestamp="1428420767", oauth_token="2993886084-58xam6y3NipJl9X3aKm2F6tEDDihv5BK7sbS6bZ", oauth_version="1.0"' --verbose

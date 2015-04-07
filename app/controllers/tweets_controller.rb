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

require Rails.root.join('lib/modules/OAuth')
require Rails.root.join('lib/modules/Tweets')

class TweetsController < ApplicationController

  def index
    byebug
    fullpath = request.fullpathnex
    @request = OAuth::AccessToken.new({params: session[:authorizedToken] + '&' + session[:tokenSecret]})
    byebug
    response = @request.Tweets::get_tweets(OAuth::get_header_string('access_token',@request.params), "https://api.twitter.com/1.1/statuses/home_timeline.json/count=200")
    byebug
  end

end

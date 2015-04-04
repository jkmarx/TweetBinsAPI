require Rails.root.join('lib/modules/OAuth')

class CallbacksController < ApplicationController

  def request_token()
    @request = OAuth::RequestToken.new()
    response = @request.request_data(OAuth::get_header_string('request_token',@request.params),OAuth::get_base_url('request_token'),'POST')
    token_param = response.body.match(/oauth_token=\w+/)[0]
    token_secret_param = response.body.match(/oauth_token_secret=\w+/)[0]
    render json: { token: token_param, secret: token_secret_param }, status: 200
  end

  def twitter_callback

  end

end

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
    fullpath = request.fullpath
    token_params = fullpath.match(/oauth_token=\w+/)[0]
    oauth_verifier = fullpath.match(/oauth_verifier=\w+/)[0]
    @request = OAuth::AccessToken.new({params: token_params + '&' + oauth_verifier})
    byebug;
    response = @request.request_data(OAuth::get_header_string('access_token',@request.params), OAuth::get_base_url('access_token'),
      'POST',@request.data)
    byebug;
    hash = convertToHash(response.body)
    redirect_to "http://localhost:9000/#/dashboard"
    byebug;
  end

  def convertToHash(string)
    string.split('&').each_with_object({}) { |i,o|
      array = i.split('=')
      o[array[0]] = array[1]
    }
  end



end

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
    byebug;
    fullpath = request.fullpath
    token_params = fullpath.match(/oauth_token=\w+/)[0]
    oauth_verifier = fullpath.match(/oauth_verifier=\w+/)[0]
    @request = OAuth::AccessToken.new({params: token_params + '&' + oauth_verifier})
    response = @request.request_data(@request.get_header_string, OAuth::get_base_url('access_token'),
      'POST',@request.data)
    hash = convertToHash(response.body)
    byebug;
  end

  def convertToHash(string)
    string.split('&').each_with_object({}) { |i,o|
      array = i.split('=')
      o[array[0]] = array[1]
    }
  end

  def self.get_header_string(param_url, param_hash)
    hash = OAuth::add_signature_to_params(param_hash,OAuth::calculate_signature(param_url,param_hash))
    header = "OAuth "
    hash.sort.each do |k,v|
      header << "#{k}=\"#{OAuth::url_encode(v)}\", "
    end
    header.slice(0..-3)
  end

end

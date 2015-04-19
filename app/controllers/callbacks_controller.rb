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
    response = @request.request_data(OAuth::get_header_string('access_token',@request.params), OAuth::get_base_url('access_token'),
                                     'POST',@request.data)

    if(response.code == "200" || response.message == "OK")
      setUser(response.body)
      redirect_to "http://localhost:9000/#/tweets"
    else
      redirect_to "http://localhost:9000/#/login"
    end
  end

  def setUser(data)
    authorized_token = data.match(/(?:oauth_token=)([\w\-]+)/)[0]
    token_secret = data.match(/(?:oauth_token_secret=)(\w+)/)[0]
    twitter_user_id = data.match(/(?:user_id=)(\d+)/)[0]
    twitter_screen_name = data.match(/(?:screen_name=)(.+)/)[0]
    user = User.find_by twitterUsername: twitter_screen_name.split('=')[1]
    user.update(accessToken: authorized_token, tokenSecret: token_secret)
  end

end

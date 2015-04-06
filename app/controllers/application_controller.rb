class ApplicationController < ActionController::API
  include ActionController::Serialization
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def default_serializer_options
    {root: false}
  end

  protected
  # Call this method as the following in your other controllers
  # before_filter :authenticate, only: [:show, :index]
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      User.find_by(appToken: token)
  end

end

module Tweets
  require 'net/http'

  def get_tweets(header, base_uri)
    byebug;
      url = URI.parse(base_uri)
      http = Net::HTTP.new(url.host, 443)
      http.use_ssl = true
      response, data = http.get(url.to_s, { 'Authorization' => header })
      byebug;
      response

  end

end

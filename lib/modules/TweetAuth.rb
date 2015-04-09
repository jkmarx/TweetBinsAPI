module TweetAuth
  require 'net/http'

  def self.get_base_url(urlType)
    if urlType == "friends"
      "https://api.twitter.com/1.1/friends/ids.json"
    else
      "https://api.twitter.com/1.1/statuses/home_timeline.json"
    end
  end

  def self.url_encode(url)
    CGI::escape(url)
  end

  def self.get_signature_base_string(param_hash, urlType, query)
      'GET' + "&" + TweetAuth::url_encode(TweetAuth::get_base_url(urlType)) +"&"+"#{query}" + TweetAuth::url_encode(TweetAuth::collect_parameters(param_hash))
  end

  def self.create_signature(tokenSecret, param_hash, urlType, query)
    Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha1'), TweetAuth::url_encode(ENV['TWITTER_CONSUMER_SECRET']) + "&#{tokenSecret}", TweetAuth::get_signature_base_string(param_hash, urlType, query))).gsub(/\n| |\r/,'')
  end

  #  def self.create_signature(tokenSecret, param_hash, urlType, query)
  #   Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha1'), TweetAuth::url_encode('MCD8BKwGdgPHvAuvgvz4EQpqDAtx89grbuNMRd7Eh98') + "&#{tokenSecret}", TweetAuth::get_signature_base_string(param_hash, urlType, query))).gsub(/\n| |\r/,'')
  # end

  def self.add_signature_to_params(hash,value)
    hash[:oauth_signature] = value
    hash
  end

  def self.get_header_string(tokenSecret, param_hash, urlType, query=nil)
    hash = TweetAuth::add_signature_to_params(param_hash,TweetAuth::create_signature(tokenSecret,param_hash, urlType, query))
    header = "OAuth "
    hash.sort.each do |k,v|
      header << "#{k}=\"#{TweetAuth::url_encode(v)}\", "
    end
    header.slice(0..-3)
  end


  def self.collect_parameters(hash)
    hash.sort.collect{ |k, v| "#{TweetAuth::url_encode(k.to_s)}=#{TweetAuth::url_encode(v)}" }.join('&')
  end

  class AuthHeader
    attr_accessor :consumer_key, :consumer_secret, :base_url, :timestamp, :callback, :params, :data

    def initialize(token)
      @consumer_key = ENV['TWITTER_CONSUMER_KEY']
      @consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      @timestamp = Time.now.utc.to_i.to_s
      @params = {
        oauth_consumer_key: "#{ENV['TWITTER_CONSUMER_KEY']}",
        oauth_nonce: "#{SecureRandom.uuid.gsub(/\-|\n|\r/,'')}",
        oauth_signature_method: "HMAC-SHA1",
        oauth_timestamp: "#{@timestamp}",
        oauth_token: token,
        oauth_version: "1.0"
      }
    end
    def request_data(header, base_uri, method, query=nil, post_data=nil)
      url = URI.parse(base_uri)
      http = Net::HTTP.new(url.host, 443)
      http.use_ssl = true
      if method == 'POST'
        response = http.post(base_uri, post_data, { 'Content-Type'=> '', 'Authorization' => header })
      else
        response = http.get(url.to_s + query, { 'Authorization' => header })
      end
    end
  end
end

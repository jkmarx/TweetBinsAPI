module Tweets
  require 'net/http'

  def self.get_base_url()
    "https://api.twitter.com/1.1/statuses/home_timeline.json"
  end

  def self.url_encode(url)
    CGI::escape(url)
  end

  def self.get_signature_base_string(param_hash)
      'GET' + "&" + Tweets::url_encode(Tweets::get_base_url()) + "&" + Tweets::url_encode(Tweets::collect_parameters(param_hash))
  end

  def self.create_signature(tokenSecret, param_hash)
    Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha1'), Tweets::url_encode(ENV['TWITTER_CONSUMER_SECRET']) + "&#{tokenSecret}", Tweets::get_signature_base_string(param_hash))).gsub(/\n| |\r/,'')
  end

  def self.add_signature_to_params(hash,value)
    hash[:oauth_signature] = value
    hash
  end

  def self.get_header_string(tokenSecret, param_hash)
    hash = Tweets::add_signature_to_params(param_hash,Tweets::create_signature(tokenSecret,param_hash))
    header = "OAuth "
    hash.sort.each do |k,v|
      header << "#{k}=\"#{Tweets::url_encode(v)}\", "
    end
    header.slice(0..-3)
  end


  def self.collect_parameters(hash)
    hash.sort.collect{ |k, v| "#{Tweets::url_encode(k.to_s)}=#{Tweets::url_encode(v)}" }.join('&')
  end

  class AuthHeader
    attr_accessor :consumer_key, :consumer_secret, :base_url, :timestamp, :callback, :params, :data

    def initialize(token, data)
      @consumer_key = ENV['TWITTER_CONSUMER_KEY']
      @consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      @timestamp = Time.now.utc.to_i.to_s
      @data = data
      @params = {
        oauth_consumer_key: "#{ENV['TWITTER_CONSUMER_KEY']}",
        oauth_nonce: "#{SecureRandom.uuid.gsub(/\-|\n|\r/,'')}",
        oauth_signature_method: "HMAC-SHA1",
        oauth_timestamp: "#{@timestamp}",
        oauth_token: token,
        oauth_version: "1.0"
      }
    end
    def request_data(header, base_uri, method, post_data=nil)
      url = URI.parse(base_uri)
      http = Net::HTTP.new(url.host, 443)
      http.use_ssl = true
      if method == 'POST'
        response = http.post(base_uri, post_data, { 'Content-Type'=> '', 'Authorization' => header })
      else
        response, data = http.get(url.to_s, { 'Authorization' => header })
      end
    end
  end

end
